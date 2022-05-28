package io.surati.gap.web.base;

import io.surati.gap.web.base.menu.DashboardMenu;
import io.surati.gap.web.base.rq.RqUser;
import io.surati.gap.web.base.xe.XeDashboardMenu;
import io.surati.gap.web.base.xe.XeDashboardMenus;
import org.cactoos.collection.Sticky;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.rs.xe.XeAppend;
import org.takes.rs.xe.XeChain;
import org.takes.rs.xe.XeSource;

import javax.sql.DataSource;

/**
 * Abstract take for dashboards.
 *
 * @since 0.5
 */
public abstract class AbstractTkDashboard implements Take {

    /**
     * Data source.
     */
    private final DataSource src;

    /**
     * Dashboard menu.
     */
    private final DashboardMenu menu;

    /**
     * Style sheet.
     */
    private final String stylesheet;

    private final InClasspath classpath;

    /**
     * Ctor.
     *
     * @param src Data source
     * @param menu Dashboard menu
     * @param stylesheet Style sheet
     */
    public AbstractTkDashboard(
        final DataSource src, final DashboardMenu menu, final String stylesheet, final InClasspath classpath
    ) {
        this.src = src;
        this.menu = menu;
        this.stylesheet = stylesheet;
        this.classpath = classpath;
    }

    protected final Response act(final Request req, final XeSource stats) throws Exception {
        final XeSource src = new XeChain(
            new XeDashboardMenu("current_dashboard", this.menu),
            new XeDashboardMenus(DashboardMenu.dashboardsAuthorized(new RqUser(this.src, req))),
            stats
        );
        return new RsPage(
            this.stylesheet,
            classpath,
            req,
            this.src,
            () -> new Sticky<>(
                new XeAppend("menu", "home"),
                src
            )
        );
    }
}
