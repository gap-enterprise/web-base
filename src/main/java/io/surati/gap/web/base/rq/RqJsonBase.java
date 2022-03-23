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

import java.io.IOException;
import javax.json.Json;
import javax.json.JsonReader;
import javax.json.JsonStructure;
import org.takes.Request;
import org.takes.rq.RqWrap;

/**
 * Base Json of a {@link Request}.
 *
 * @since 3.0
 */
public final class RqJsonBase extends RqWrap implements RqJson {
	
	/**
     * Request.
     */
    private final Request req;
    
    /**
     * Ctor.
     * @param request Original request
     */
    public RqJsonBase(final Request request) {
        super(request);
        this.req = request;
    }

	@Override
	public JsonStructure payload() throws IOException {			
		JsonReader reader = null;		
		try {
			reader = Json.createReader(req.body());
			return reader.read();
		} finally {
			if(reader != null)
				reader.close();
		}
	}
}
