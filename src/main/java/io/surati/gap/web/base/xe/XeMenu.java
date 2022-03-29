/*
 * Copyright (c) 2022 Surati
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package io.surati.gap.web.base.xe;

import com.minlessika.map.CleanMap;
import io.surati.gap.admin.base.api.Access;
import io.surati.gap.web.base.menu.Menu;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

/**
 * XeMenu.
 *
 * @since 0.4
 */
public final class XeMenu extends XeWrap {

	public XeMenu(final String name, final Menu item) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add(
						new CleanMap<>()
							.add("order", item.order())
							.add("icon", item.icon())
							.add("name", item.name())
							.add("color", item.color())
							.add("description", item.description())
					).add("submenus")
					.append(
						new Joined<>(
							new Mapped<>(
								submenu -> new XeSubmenu(
									"submenu", submenu
								).toXembly(),
								item.submenus()
							)
						)
					).up()
				.up()

			)
		);
	}
}
