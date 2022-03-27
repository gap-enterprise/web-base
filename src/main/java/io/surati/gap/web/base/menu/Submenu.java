package io.surati.gap.web.base.menu;

import io.surati.gap.admin.base.api.Access;

/**
 * Submenu.
 *
 * @since 0.4
 */
public interface Submenu {

    int order();

    String icon();

    String name();

    String link();

    Iterable<? extends Access> accesses();

    boolean toSeparate();
}
