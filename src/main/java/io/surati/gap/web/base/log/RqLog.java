/*
 * Copyright (c) 2022 Surati

 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
	
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package io.surati.gap.web.base.log;

import io.surati.gap.admin.base.api.EventLog;
import io.surati.gap.admin.base.api.Log;
import io.surati.gap.admin.base.db.DbLog;
import io.surati.gap.web.base.rq.RqUser;
import java.io.IOException;
import javax.sql.DataSource;
import org.takes.Request;

/**
 * Log that uses the logged user.
 *
 * @since 0.3
 */
public final class RqLog implements Log {

	private final Log origin;

	/**
	 * Ctor.
	 * @param source Data source
	 * @param req Request
	 */
	public RqLog(final DataSource source, final Request req) {
		this(
			new DbLog(
				source, loginFrom(source, req), ipAddressFrom(req)
			)
		);
	}

	/**
	 * Ctor.
	 * @param log Log
	 */
	public RqLog(final Log log) {
		this.origin = log;
	}

	@Override
	public void info(String message, Object... args) {
		this.origin.info(message, args);
	}

	@Override
	public void warning(String message, Object... args) {
		this.origin.warning(message, args);
	}

	@Override
	public void error(String message, String details) {
		this.origin.error(message, details);
	}

	@Override
	public Iterable<EventLog> iterate() {
		return this.origin.iterate();
	}

	@Override
	public void info(String message) {
		this.origin.info(message);
	}

	@Override
	public void warning(String message) {
		this.origin.warning(message);
	}

	/**
	 * IP address from request.
	 * @param req Request
	 * @return IP address
	 */
	private static String ipAddressFrom(Request req) {
		try {
			for (String head : req.head()) {
				if(head.contains("X-Takes-RemoteAddress")) {
					return head.split(":")[1].trim();
				}
			}
			return "127.0.0.1";
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		}
	}

	/**
	 * Login from request.
	 * @param source Data source
	 * @param req Request
	 * @return Login
	 */
	private static String loginFrom(final DataSource source, final Request req) {
		try {
			return new RqUser(source, req).login();
		} catch (Exception e) {
			return "anonymous";
		}
	}
}
