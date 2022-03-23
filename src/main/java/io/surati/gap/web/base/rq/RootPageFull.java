/*
 * MIT License
 *
 * Copyright (c) 2022 Surati
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package io.surati.gap.web.base.rq;

import org.takes.Request;
import org.takes.rq.RqHref;

import java.io.IOException;
import java.util.Base64;

final public class RootPageFull {

	final String title;

	final String subtitle;

	final String uri;
	
	public RootPageFull(final Request req) throws IOException {
		this(
			new RqHref.Smart(req).single("root_page_title"),
			new RqHref.Smart(req).single("root_page_subtitle"),
			new String(
				Base64.getUrlDecoder().decode(
					new RqHref.Smart(req).single("root_page_uri")
				)
			)
		);
	}
	
	public RootPageFull(final String title, final String subtitle, final String uri) {
		this.title = new UriDecode(title).toString();
		this.subtitle = new UriDecode(subtitle).toString();
		this.uri = uri;
	}
	
	@Override
	public String toString() {
		return String.format(
			"root_page_title=%s&root_page_subtitle=%s&root_page_uri=%s",
			new UriEncode(this.title),
			new UriEncode(this.subtitle),
			Base64.getUrlEncoder().encodeToString(this.uri.getBytes())
		);
	}
}
