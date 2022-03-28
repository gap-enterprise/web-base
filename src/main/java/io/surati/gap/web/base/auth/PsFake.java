package io.surati.gap.web.base.auth;

import io.surati.gap.admin.base.api.User;
import org.takes.Request;
import org.takes.Response;
import org.takes.facets.auth.Identity;
import org.takes.facets.auth.Pass;
import org.takes.misc.Opt;

public final class PsFake implements Pass {

    private final User user;

    public PsFake(final User user) {
        this.user = user;
    }

    @Override
    public Opt<Identity> enter(final Request request) throws Exception {
        return new Opt.Single<>(
            new GIdentity(this.user)
        );
    }

    @Override
    public Response exit(final Response response, final Identity identity) throws Exception {
        return response;
    }
}
