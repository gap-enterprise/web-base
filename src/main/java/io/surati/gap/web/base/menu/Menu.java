package io.surati.gap.web.base.menu;

import io.surati.gap.admin.api.Access;
import io.surati.gap.admin.api.ProfileAccesses;
import io.surati.gap.admin.api.User;
import java.util.LinkedList;
import java.util.List;

/**
 * Menu.
 *
 * @since 0.4
 */
public interface Menu {

    int order();

    String icon();

    String name();

    String color();

    String description();

    Iterable<Submenu> submenus();

    List<Menu> VALUES = new LinkedList<>();

    static Iterable<Menu> menusAuthorized(final User user) {
        final List<Menu> results = new LinkedList<>();
        for (final Menu menu : Menu.VALUES) {
            final List<Submenu> subauths = new LinkedList<>();
            final ProfileAccesses useracs = user.profile().accesses();
            for (final Submenu sub : menu.submenus()) {
                for (final Access acs : sub.accesses()) {
                    if (useracs.has(acs)) {
                        subauths.add(sub);
                        break;
                    }
                }
            }
            if (!subauths.isEmpty()) {
                results.add(
                    new SimpleMenu(
                        menu.order(), menu.icon(), menu.name(), menu.color(),
                        menu.description(), subauths
                    )
                );
            }
        }
        return results;
    }
}
