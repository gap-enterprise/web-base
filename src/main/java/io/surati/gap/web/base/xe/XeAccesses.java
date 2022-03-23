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

import io.surati.gap.admin.api.Access;
import io.surati.gap.admin.api.ProfileAccesses;
import org.cactoos.iterable.Joined;
import org.cactoos.iterable.Mapped;
import org.takes.rs.xe.XeDirectives;
import org.takes.rs.xe.XeWrap;
import org.xembly.Directives;

/**
 * XeAccesses.
 *
 * @since 0.3
 */
public final class XeAccesses extends XeWrap {
	
	public XeAccesses(final ProfileAccesses profileAccesses) {
		this(profileAccesses.iterate());
	}
	
	public XeAccesses(final Iterable<Access> items) {
		this("accesses", items);
	}
	
	public XeAccesses(final String name, final Iterable<Access> items) {
		super(
			new XeDirectives(
				new Directives()
					.add(name)
					.append(
						new Joined<>(
							new Mapped<>(
								item -> new XeAccess("access", item).toXembly(),
								items
							)
						)
					)
			)
		);
	}
}
