package io.surati.gap.web.base;

import io.surati.gap.database.utils.exceptions.DatabaseException;
import java.sql.Connection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;

/**
 * Take that automatically put database operations in a transaction.
 * <p>
 *     We assume that only thread connection is used in origin take for database operations
 *     and that this thread is set to auto commit at false.
 * </p>
 *
 * @since 0.7
 */
public final class TkTransaction implements Take {

    /**
     * Logger.
     */
    private final static Logger logger = LoggerFactory.getLogger(TkTransaction.class);

    /**
     * Connection in the thread.
     */
    private final ThreadLocal<Connection> connection;

    /**
     * Take to put within transaction
     */
    private final Take origin;

    /**
     *
     * @param origin Origin
     * @param connection Connection in the thread
     */
    public TkTransaction(final Take origin, final ThreadLocal<Connection> connection) {
        this.origin = origin;
        this.connection = connection;
    }

    @Override
    public Response act(final Request req) throws Exception {
        try {
            final Response response = origin.act(req);
            if (connection.get() != null) {
                connection.get().commit();
            }
            return response;
        } catch (final DatabaseException exe) {
            if (connection.get() != null) {
                connection.get().rollback();
            }
            logger.error(exe.getLocalizedMessage(), exe);
            throw exe;
        } finally {
            if (connection.get() != null) {
                connection.get().close();
                connection.remove();
            }
        }
    }
}
