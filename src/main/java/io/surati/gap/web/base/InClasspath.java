package io.surati.gap.web.base;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;
import org.cactoos.io.ReaderOf;

public final class InClasspath implements URIResolver {

    private final Class<?> clazz;

    public InClasspath(final Class<?> clazz) {
        this.clazz = clazz;
    }

    @Override
    public Source resolve(final String href, final String base)
        throws TransformerException {
        final URI uri;
        if (base == null || base.isEmpty()) {
            uri = URI.create(href);
        } else {
            uri = URI.create(base).resolve(href);
        }
        final InputStream input;
        if (uri.isAbsolute()) {
            try {
                input = uri.toURL().openStream();
            } catch (final IOException ex) {
                throw new IllegalStateException(ex);
            }
        } else {
            input = clazz.getResourceAsStream(uri.getPath());
            if (input == null) {
                throw new TransformerException(
                    String.format(
                        "\"%s\" not found in classpath, base=\"%s\"",
                        href, base
                    )
                );
            }
        }
        return new StreamSource(
            new ReaderOf(input)
        );
    }
}
