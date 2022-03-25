package io.surati.gap.web.base.menu;

import io.surati.gap.admin.api.Access;
import io.surati.gap.admin.api.ProfileAccesses;
import io.surati.gap.admin.api.User;

import java.util.LinkedList;
import java.util.List;

/**
 * Dashboard menu.
 *
 * @since 0.5
 */
public interface DashboardMenu {

    int order();

    String code();

    String title();

    String link();

    Iterable<? extends Access> accesses();

    List<DashboardMenu> VALUES = new LinkedList<>();

    static Iterable<DashboardMenu> dashboardsAuthorized(final User user) {
        final List<DashboardMenu> results = new LinkedList<>();
        final ProfileAccesses useracs = user.profile().accesses();
        for (final DashboardMenu menu : DashboardMenu.VALUES) {
            for (final Access acs : menu.accesses()) {
                if (useracs.has(acs)) {
                    results.add(menu);
                    break;
                }
            }
        }
        return results;
    }

    DashboardMenu BLANK = new DashboardMenu() {

        @Override
        public int order() {
            return 0;
        }

        @Override
        public String code() {
            return "blank";
        }

        @Override
        public String title() {
            return "Blank dashboard";
        }

        @Override
        public String link() {
            return "javascript:void()";
        }

        @Override
        public Iterable<? extends Access> accesses() {
            return new LinkedList<>();
        }
    };
}
