package io.surati.gap.web.base;

import com.minlessika.utils.PreviousLocation;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.logging.Level;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.takes.Response;
import org.takes.Take;
import org.takes.facets.auth.RsLogout;
import org.takes.facets.fallback.Fallback;
import org.takes.facets.fallback.FbChain;
import org.takes.facets.fallback.FbStatus;
import org.takes.facets.fallback.RqFallback;
import org.takes.facets.fallback.TkFallback;
import org.takes.facets.flash.RsFlash;
import org.takes.facets.forward.RsForward;
import org.takes.misc.Opt;
import org.takes.rs.RsHtml;
import org.takes.rs.RsText;
import org.takes.rs.RsVelocity;
import org.takes.rs.RsWithStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.takes.tk.TkWrap;

/**
 * Take that shows a relevant page according to an error occured.
 *
 * @since 0.6
 */
public class TkSafe extends TkWrap {

    /**
     * Logger.
     */
    private static Logger logger = LoggerFactory.getLogger(TkSafe.class);

    /**
<<<<<<< HEAD
     * Ctor.
     * @param take Take to safe
     */
    public TkSafe(final Take take) {
        super(TkSafe.safe(take));
    }

    /**
=======
>>>>>>> upstream/master
     * With fallback.
     * @param take Takes
     * @return Safe takes
     */
    private static Take safe(final Take take){
        return new TkFallback(
            take,
            new FbChain(
                new FbStatus(
                    HttpURLConnection.HTTP_NOT_FOUND,
                    (Fallback) req -> {
                        final Throwable ex = req.throwable();
                        final Throwable cause = ExceptionUtils.getRootCause(ex);
                        logger.error("Exception erreur 404 - Ressource non trouvée", cause);
                        return new Opt.Single<>(
                            new RsWithStatus(
                                new RsHtml(
                                    new RsVelocity(
                                        TkSafe.class.getResource("/io/surati/gap/web/base/vm/404.html.vm")
                                    )
                                ),
                                HttpURLConnection.HTTP_NOT_FOUND
                            )
                        );
                    }
                ),
                new FbStatus(
                    HttpURLConnection.HTTP_BAD_REQUEST,
                    (Fallback) req -> {
                        final Throwable ex = req.throwable();
                        final Throwable cause = ExceptionUtils.getRootCause(ex);
                        logger.error("Exception erreur 400 - Mauvaise requête", cause);
                        final String fullMessage = ex.getLocalizedMessage();
                        final String message = fullMessage.split("\\[400\\]")[1].trim();
                        if(message.startsWith("IllEg:")) {
                            String url = new PreviousLocation(req, "/home").toString();
                            return new Opt.Single<>(
                                new RsForward(
                                    new RsFlash(
                                        message.replaceFirst("IllEg:", ""),
                                        Level.WARNING
                                    ),
                                    url
                                )
                            );
                        } else {
                            return new Opt.Single<>(
                                new RsWithStatus(
                                    new RsHtml(
                                        new RsText(ex.getLocalizedMessage())
                                    ),
                                    HttpURLConnection.HTTP_BAD_REQUEST
                                )
                            );
                        }
                    }
                ),
                new FbStatus(
                    HttpURLConnection.HTTP_UNAUTHORIZED,
                    (Fallback) req -> {
                        final Throwable ex = req.throwable();
                        final Throwable cause = ExceptionUtils.getRootCause(ex);
                        logger.error("Exception erreur 401 - Accès non authorisé", cause);
                        return new Opt.Single<>(
                            new RsLogout(
                                new RsForward(
                                    new RsFlash(
                                        "Vous devez vous connecter avant de continuer !",
                                        Level.WARNING
                                    ),
                                    "/login"
                                )
                            )
                        );
                    }
                ),
                new FbStatus(
                    HttpURLConnection.HTTP_FORBIDDEN,
                    (Fallback) req -> {
                        final Throwable ex = req.throwable();
                        final Throwable cause;
                        if(ExceptionUtils.getRootCause(ex) == null) {
                            cause = ex;
                        } else {
                            cause = ExceptionUtils.getRootCause(ex);
                        }
                        logger.error("Exception erreur 403 - Accès Interdit", cause);
                        return new Opt.Single<>(
                            new RsForward(
                                new RsFlash(
                                    "Vous n'avez pas suffisamment de droits pour accéder à cette ressource !",
                                    Level.WARNING
                                ),
                                "/home"
                            )
                        );
                    }
                ),
                req -> new Opt.Single<>(TkSafe.fatal(req))
            )
        );
    }

    /**
     * Make fatal error page.
     * @param req Request
     * @return Response
     * @throws IOException
     * @throws Exception
     */
    private static Response fatal(final RqFallback req) throws IOException {
        final Throwable ex = req.throwable();
        final Throwable cause = ExceptionUtils.getRootCause(ex);
        logger.error("Exception erreur 500", cause);
        return new RsWithStatus(
            new RsHtml(
                new RsVelocity(
                    TkSafe.class.getResource("/io/surati/gap/web/base/vm/500.html.vm")
                )
            ),
            HttpURLConnection.HTTP_INTERNAL_ERROR
        );
    }
}
