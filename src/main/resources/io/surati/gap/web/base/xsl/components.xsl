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
  <xsl:template name="takes_flash_without_escaping">
    <xsl:param name="flash"/>
    <xsl:if test="$flash/message">
      <xsl:choose>
        <xsl:when test="$flash/level = 'INFO'">
          <div class="mbg-3 alert-dismissible fade show alert alert-info" role="alert">
            <span class="pr-2">
              <i class="fa fa-info-circle"/>
            </span>
            <xsl:value-of select="$flash/message" disable-output-escaping="yes"/>
          </div>
        </xsl:when>
        <xsl:when test="$flash/level = 'WARNING'">
          <div class="mbg-3 alert-dismissible fade show alert alert-warning" role="alert">
            <span class="pr-2">
              <i class="fa fa-exclamation-circle"/>
            </span>
            <xsl:value-of select="$flash/message" disable-output-escaping="yes"/>
          </div>
        </xsl:when>
        <xsl:when test="$flash/level = 'FINE'">
          <div class="mbg-3 alert-dismissible fade show alert alert-success" role="alert">
            <span class="pr-2">
              <i class="fa fa-check-circle"/>
            </span>
            <xsl:value-of select="$flash/message" disable-output-escaping="yes"/>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <div class="mbg-3 alert-dismissible fade show alert alert-danger" role="alert">
            <span class="pr-2">
              <i class="fa fa-exclamation-circle"/>
            </span>
            <xsl:value-of select="$flash/message" disable-output-escaping="yes"/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
