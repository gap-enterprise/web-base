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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sec="http://www.surati.io/Security/User/Profile" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title>
      <xsl:text>GAP - Tableau de bord</xsl:text>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div>
            <div class="page-title-head center-elem">
              <span class="d-inline-block pr-2">
                <i class="lnr-apartment opacity-6"/>
              </span>
              <span class="d-inline-block">Tableau de bord</span>
            </div>
            <div class="page-title-subheading opacity-10">
              <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a>
                      <i aria-hidden="true" class="fa fa-home"/>
                    </a>
                  </li>
                  <li class="active breadcrumb-item" aria-current="page">
                      Tableau de bord
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="body">
    <xsl:if test="count(dashboard_menus/dashboard_menu) &gt; 0">
      <div class="container">
        <ul class="tabs-animated-shadow tabs-animated nav nav-justified tabs-rounded-lg">
          <xsl:for-each select="dashboard_menus/dashboard_menu">
            <xsl:sort select="order"/>
            <li class="nav-item">
              <a role="tab" class="nav-link" href="{link}" aria-selected="false">
                <xsl:if test="code = ../../current_dashboard/code">
                  <xsl:attribute name="class">
                    nav-link show active
                  </xsl:attribute>
                  <xsl:attribute name="aria-selected">
                    true
                  </xsl:attribute>
                </xsl:if>
                <span>
                  <xsl:value-of select="name"/>
                </span>
              </a>
            </li>
          </xsl:for-each>
        </ul>
      </div>
    </xsl:if>
    <xsl:apply-templates select="." mode="dashboard"/>
  </xsl:template>
  <xsl:template match="page" mode="custom-script"/>
</xsl:stylesheet>
