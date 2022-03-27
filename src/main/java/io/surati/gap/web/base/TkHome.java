/**
MIT License

Copyright (c) 2021 Surati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
package io.surati.gap.web.base;

import io.surati.gap.admin.base.api.User;
import io.surati.gap.web.base.menu.DashboardMenu;
import io.surati.gap.web.base.rq.RqUser;
import org.cactoos.list.ListOf;
import org.takes.Request;
import org.takes.Response;
import org.takes.Take;
import org.takes.facets.forward.RsForward;

import javax.sql.DataSource;
import java.util.List;

/**
 * Take that displays user's home.
 *
 * <p>The class is immutable and thread-safe.</p>
 *
 * @since 0.5
 */
public final class TkHome implements Take {

	/**
	 * Data source.
	 */
	final DataSource src;

	public TkHome(final DataSource src) {
		this.src = src;
	}

	@Override
	public Response act(Request req) throws Exception {
		final List<DashboardMenu> menus = new ListOf<>(
			DashboardMenu.dashboardsAuthorized(
				new RqUser(this.src, req)
			)
		);
		final Response resp;
		if (menus.isEmpty()) {
			resp = new RsForward("/dashboard/blank");
		} else {
			resp = new RsForward(menus.get(0).link());
		}
		return resp;
	}

}
