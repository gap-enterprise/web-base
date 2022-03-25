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
import io.surati.gap.web.base.menu.DashboardMenu;
import io.surati.gap.web.base.menu.Menu;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

/**
 * XeMenu.
 *
 * @since 0.5
 */
public final class XeDashboardMenu extends XeWrap {

	public XeDashboardMenu(final String name, final DashboardMenu item) {
		super(
			new XeDirectives(
				new Directives()
				.add(name)
					.add(
						new CleanMap<>()
							.add("order", item.order())
							.add("code", item.code())
							.add("name", item.name())
							.add("link", item.link())
					)
				.up()

			)
		);
	}
}
