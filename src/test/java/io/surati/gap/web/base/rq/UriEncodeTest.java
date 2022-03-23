package io.surati.gap.web.base.rq;

import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.Test;

final class UriEncodeTest {

    @Test
    void encodes() {
        MatcherAssert.assertThat(
            new UriEncode("https://gap.surati.io/login").toString(),
            Matchers.equalTo("https%3A%2F%2Fgap.surati.io%2Flogin")
        );
    }
}
