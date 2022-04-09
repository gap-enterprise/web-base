package io.surati.gap.web.base.menu;

import io.surati.gap.admin.base.api.Access;
import io.surati.gap.admin.base.api.ProfileAccesses;
import io.surati.gap.admin.base.api.User;
import java.util.LinkedList;
import java.util.List;

/**
 * Menu.
 *
 * @since 0.4
 */
public interface Menu {

    int order();

    String code();

    String icon();

    String name();

    String color();

    String description();

    Iterable<Submenu> submenus();

    void addSubmenu(Submenu submenu);

    void addSubmenus(Iterable<Submenu> submenus);

    List<Menu> VALUES = new LinkedList<>();

    /**
     * Inserts a submenu in a menu.
     * @param code Code of menu
     * @param submenu Submenu to insert
     * @throws IllegalArgumentException If parent menu not found
     */
    static void insertSubmenu(final String code, final Submenu submenu) {
        boolean found = false;
        for (final Menu item : Menu.VALUES) {
            if (item.code().equals(code)) {
                item.addSubmenu(submenu);
                found = true;
                break;
            }
        }
        if (!found) {
            throw new IllegalArgumentException(
                String.format("Menu with code %s not found !", code)
            );
        }
    }

    static Iterable<Menu> menusAuthorized(final User user) {
        final List<Menu> results = new LinkedList<>();
        final ProfileAccesses useracs = user.profile().accesses();
        for (final Menu menu : Menu.VALUES) {
            final List<Submenu> subauths = new LinkedList<>();
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
                        menu.order(), menu.code(), menu.icon(), menu.name(), menu.color(),
                        menu.description(), subauths
                    )
                );
            }
        }
        return results;
    }
}
