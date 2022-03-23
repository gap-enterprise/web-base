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
package io.surati.gap.web.base;

import io.surati.gap.web.base.log.RqLog;
import java.net.HttpURLConnection;
import javax.sql.DataSource;
import org.takes.HttpException;
import org.takes.Take;
import org.takes.tk.TkWrap;

/**
 * Take that safely alert user.
 *
 * @since 0.3
 */
public final class TkSafeUserAlert extends TkWrap  {

	public TkSafeUserAlert(final DataSource source, final Take take) {
		super(
			(req) -> {
				try {
					return take.act(req);
				} catch (IllegalArgumentException ex) {
					new RqLog(source, req).warning(ex.getLocalizedMessage());
					throw new HttpException(
		                HttpURLConnection.HTTP_BAD_REQUEST,
		                String.format(
		                    "IllEg:%s",
		                    ex.getLocalizedMessage()
		                )
		            );
				}
			}
		);
	}
}
