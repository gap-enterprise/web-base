package io.surati.gap.web.base.menu;

import io.surati.gap.admin.base.api.Access;

/**
 * Simple submenu.
 *
 * @since 0.4
 */
public final class SimpleSubmenu implements Submenu {

    private final String code;
    private final int order;
    private final String icon;
    private final String name;
    private final String link;
    private final Iterable<Access> accesses;
    private final boolean toseparate;

    public SimpleSubmenu(
        final int order, final String code, final String icon, final String name,
        final String link, final Iterable<Access> accesses, final boolean toseparate
    ) {
        this.order = order;
        this.code = code;
        this.icon = icon;
        this.name = name;
        this.link = link;
        this.accesses = accesses;
        this.toseparate = toseparate;
    }

    @Override
    public String code() {
        return this.code;
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
    public String link() {
        return this.link;
    }

    @Override
    public Iterable<Access> accesses() {
        return this.accesses;
    }

    @Override
    public boolean toSeparate() {
        return this.toseparate;
    }
}
