<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2022 Surati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to read
the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/org/takes/rs/xe/memory.xsl"/>
  <xsl:include href="/org/takes/rs/xe/millis.xsl"/>
  <xsl:include href="/org/takes/facets/flash/flash.xsl"/>
  <xsl:include href="/xsl/components.xsl"/>
  <xsl:template match="/page">
    <html lang="fr">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" href="/img/logo.ico"/>
        <link rel="stylesheet" href="/css/style.css"/>
        <xsl:apply-templates select="." mode="head"/>
      </head>
      <body>
        <section>
          <article>
            <xsl:apply-templates select="." mode="body"/>
          </article>
        </section>
      </body>
      <script src="/js/main.js"/>
    </html>
  </xsl:template>
</xsl:stylesheet>
