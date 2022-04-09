package io.surati.gap.web.base.menu;

import java.util.LinkedList;
import java.util.List;
import org.cactoos.iterable.IterableOf;
import org.cactoos.list.ListOf;

/**
 * Simple menu.
 *
 * @since 0.4
 */
public final class SimpleMenu implements Menu {

    private final String code;
    private final int order;
    private final String icon;
    private final String name;
    private final String color;
    private final String description;
    private final List<Submenu> submenus;

    public SimpleMenu(
        final int order, final String code, final String icon, final String name,
        final String color, final String description,
        final Iterable<Submenu> submenus
    ) {
        this.order = order;
        this.code = code;
        this.icon = icon;
        this.name = name;
        this.color = color;
        this.description = description;
        this.submenus = new LinkedList<>(new ListOf<>(submenus));
    }
    @Override
    public int order() {
        return this.order;
    }

    @Override
    public String code() {
        return this.code;
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

    @Override
    public void addSubmenu(final Submenu submenu) {
        this.addSubmenus(new IterableOf<>(submenu));
    }

    @Override
    public void addSubmenus(final Iterable<Submenu> submenus) {
        for (final Submenu item : submenus) {
            this.submenus.add(item);
        }
    }
}
