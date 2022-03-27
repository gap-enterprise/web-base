package io.surati.gap.web.base.menu;

import io.surati.gap.admin.base.api.Access;

/**
 * Simple menu.
 *
 * @since 0.4
 */
public final class SimpleMenu implements Menu {

    private final int order;
    private final String icon;
    private final String name;
    private final String color;
    private final String description;
    private final Iterable<Submenu> submenus;

    public SimpleMenu(
        final int order, final String icon, final String name,
        final String color, final String description,
        final Iterable<Submenu> submenus
    ) {
        this.order = order;
        this.icon = icon;
        this.name = name;
        this.color = color;
        this.description = description;
        this.submenus = submenus;
    }
    @Override
    public int order() {
        return this.order;
    }

    @Override
    public String icon() {
        return this.icon;
    }

    @Override
    public String name() {
        return this.name;
    }

    @Override
    public String color() {
        return this.color;
    }

    @Override
    public String description() {
        return this.description;
    }

    @Override
    public Iterable<Submenu> submenus() {
        return this.submenus;
    }
}
