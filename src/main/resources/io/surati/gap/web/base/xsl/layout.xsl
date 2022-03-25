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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sec="http://www.surati.io/Security/User/Profile" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/org/takes/rs/xe/memory.xsl"/>
  <xsl:include href="/org/takes/rs/xe/millis.xsl"/>
  <xsl:include href="/org/takes/facets/flash/flash.xsl"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/components.xsl"/>
  <xsl:function name="sec:hasAccess" as="xs:boolean">
    <xsl:param name="nodes"/>
    <xsl:param name="access" as="xs:string"/>
    <xsl:value-of select="count($nodes/current_user_accesses/access[id=$access]) &gt; 0"/>
  </xsl:function>
  <xsl:template match="/page">
    <html lang="fr">
      <head>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="msapplication-tap-highlight" content="no"/>
        <link rel="shortcut icon" href="/io/surati/gap/web/base/img/logo.ico"/>
        <link rel="stylesheet" href="/io/surati/gap/web/base/css/style.css"/>
        <link rel="stylesheet" href="/io/surati/gap/web/base/css/custom.css"/>
        <xsl:apply-templates select="." mode="head"/>
      </head>
      <body>
        <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar">
          <div class="app-header header-shadow">
            <div class="app-header__logo" style="width: auto;">
              <div class="logo-src1">
                <a href="/home">
                  <img src="/io/surati/gap/web/base/img/logo.png" style="height:50px;"/>
                </a>
              </div>
              <div class="header__pane ml-auto hide-display">
                <div>
                  <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                    <span class="hamburger-box">
                      <span class="hamburger-inner"/>
                    </span>
                  </button>
                </div>
              </div>
            </div>
            <div class="app-header__mobile-menu">
              <div>
                <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                  <span class="hamburger-box">
                    <span class="hamburger-inner"/>
                  </span>
                </button>
              </div>
            </div>
            <div class="app-header__menu">
              <span>
                <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                  <span class="btn-icon-wrapper">
                    <i class="fa fa-ellipsis-v fa-w-6"/>
                  </span>
                </button>
              </span>
            </div>
            <div class="app-header__content">
              <div class="app-header-left">
                <ul class="header-megamenu nav">
                  <li class="nav-item">
                    <a href="/home" class="nav-link"><i class="nav-link-icon lnr-apartment"> </i> Accueil
                      <i class="fa ml-2 opacity-5"/>
                    </a>
                  </li>
                  <xsl:for-each select="menus/menu">
                    <xsl:sort select="order"/>
                    <li class="dropdown nav-item">
                      <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false">
                        <i class="nav-link-icon {icon}"/>
                        <xsl:value-of select="name"/>
                        <i class="fa fa-angle-down ml-2 opacity-5"/>
                      </a>
                      <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                        <div class="dropdown-menu-header">
                          <div class="dropdown-menu-header-inner {color}">
                            <div class="menu-header-image opacity-1" style="background-image: url('/io/surati/gap/web/base/img/abstract.jpg');"/>
                            <div class="menu-header-content text-left">
                              <h5 class="menu-header-title">
                                <xsl:value-of select="name"/>
                              </h5>
                              <h6 class="menu-header-subtitle">
                                <xsl:value-of select="description"/>
                              </h6>
                            </div>
                          </div>
                        </div>
                        <xsl:for-each select="submenus/submenu">
                          <xsl:sort select="order"/>
                          <xsl:if test="to_separate = 'true'">
                            <div tabindex="-1" class="dropdown-divider"/>
                          </xsl:if>
                          <a href="{link}" tabindex="{position()}" class="dropdown-item">
                            <i class="dropdown-icon {icon}"/>
                            <xsl:value-of select="name"/>
                          </a>
                        </xsl:for-each>
                      </div>
                    </li>
                  </xsl:for-each>
                  <li class="nav-item">
                    <a href="javascript:void(0);" class="nav-link"><i class="nav-link-icon lnr-graduation-hat"> </i> Aide
                      <i class="fa ml-2 opacity-5"/>
                    </a>
                  </li>
                </ul>
              </div>
              <div class="app-header-right">
                <div class="header-btn-lg pr-0">
                  <div class="widget-content p-0">
                    <div class="widget-content-wrapper">
                      <div class="widget-content-left">
                        <div class="btn-group">
                          <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="p-0 btn">
                            <img width="42" class="rounded-circle" src="{identity/photo}" alt=""/>
                            <i class="fa fa-angle-down ml-2 opacity-8"/>
                          </a>
                          <div tabindex="-1" role="menu" aria-hidden="true" class="rm-pointers dropdown-menu-lg dropdown-menu dropdown-menu-right">
                            <div class="dropdown-menu-header">
                              <div class="dropdown-menu-header-inner bg-info">
                                <div class="menu-header-image opacity-2"/>
                                <div class="menu-header-content text-left">
                                  <div class="widget-content p-0">
                                    <div class="widget-content-wrapper">
                                      <div class="widget-content-left mr-3">
                                        <a href="/user-profile">
                                          <img width="42" class="rounded-circle" src="{identity/photo}" alt=""/>
                                        </a>
                                      </div>
                                      <div class="widget-content-left">
                                        <div class="widget-heading">
                                          <xsl:if test="identity">
                                            <xsl:text>@</xsl:text>
                                            <xsl:value-of select="identity/login"/>
                                          </xsl:if>
                                          <xsl:if test="not(identity)">
                                            <a href="/login ">
																				Login
																			</a>
                                          </xsl:if>
                                        </div>
                                        <div class="widget-subheading opacity-8">
                                          <xsl:if test="identity">
                                            <xsl:value-of select="identity/profile"/>
                                          </xsl:if>
                                        </div>
                                      </div>
                                      <div class="widget-content-right mr-2">
                                        <xsl:if test="identity">
                                          <a class="btn-pill btn-shadow btn-shine btn btn-focus" href="/logout">
                                            <xsl:text>Se déconnecter</xsl:text>
                                          </a>
                                        </xsl:if>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <ul class="nav flex-column">
                              <li class="nav-item-btn text-center nav-item">
                                <a href="/user-profile" class="ladda-button btn btn-pill btn-info btn-sm" data-style="slide-right">
                                  <span class="ladda-label">
                                    <xsl:text>Voir votre profil</xsl:text>
                                  </span>
                                  <span class="ladda-spinner"/>
                                  <div class="ladda-progress" style="width: 0px;"/>
                                </a>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="app-main">
            <div class="app-sidebar sidebar-shadow">
              <div class="app-header__logo">
                <div class="logo-src"/>
                <div class="header__pane ml-auto">
                  <div>
                    <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                      <span class="hamburger-box">
                        <span class="hamburger-inner"/>
                      </span>
                    </button>
                  </div>
                </div>
              </div>
              <div class="app-header__mobile-menu">
                <div>
                  <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                    <span class="hamburger-box">
                      <span class="hamburger-inner"/>
                    </span>
                  </button>
                </div>
              </div>
              <div class="app-header__menu">
                <span>
                  <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                    <span class="btn-icon-wrapper">
                      <i class="fa fa-ellipsis-v fa-w-6"/>
                    </span>
                  </button>
                </span>
              </div>
              <div class="scrollbar-sidebar">
                <div class="app-sidebar__inner">
                  <ul class="vertical-nav-menu">
                    <xsl:for-each select="menus/menu">
                      <li class="app-sidebar__heading">
                        <xsl:value-of select="name"/>
                      </li>
                      <li class="">
                        <a class="menu-size" href="#">
                          <i class="metismenu-icon {icon}"/>
                          <xsl:value-of select="description"/>
                          <i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                        </a>
                        <ul>
                          <xsl:for-each select="submenus/submenu">
                            <xsl:if test="to_separate = 'true'">
                              <div tabindex="-1" class="dropdown-divider"/>
                            </xsl:if>
                            <li>
                              <a class="menu-size" href="{url}">
                                <i class="metismenu-icon"/>
                                <xsl:value-of select="name"/>
                              </a>
                            </li>
                          </xsl:for-each>
                        </ul>
                      </li>
                    </xsl:for-each>
                    <li class="app-sidebar__heading">Aide</li>
                    <li>
                      <a href="javascript:void(0);" class="menu-size"><i class="metismenu-icon lnr-graduation-hat"/>Aide
                      </a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="app-main__outer outer-pad">
              <div class="app-main__inner inner-pad">
                <div class="">
                  <xsl:apply-templates select="." mode="header"/>
                  <xsl:call-template name="takes_flash_without_escaping">
                    <xsl:with-param name="flash" select="flash"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="." mode="body"/>
                </div>
              </div>
              <div class="app-wrapper-footer">
                <div class="app-footer">
                  <div class="app-footer__inner">
                    <div class="app-footer-left">
                      <div class="footer-dots">
                        <div class="dropdown">
                          <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-xl rm-pointers dropdown-menu">
                            <div class="tab-content">
                              <div class="tab-pane active" id="tab-messages-header1" role="tabpanel">
                                <div class="scroll-area-sm">
                                  <div class="scrollbar-container"/>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="app-footer-right">
                      <ul class="header-megamenu nav">
                        <li title="Currently deployed version" class="nav-item">
                          <a class="nav-link">
                            <xsl:text>v</xsl:text>
                            <xsl:value-of select="version/name"/>
                          </a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link">
                            <xsl:call-template name="takes_millis">
                              <xsl:with-param name="millis" select="millis"/>
                            </xsl:call-template>
                          </a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link">
                            <xsl:call-template name="takes_memory">
                              <xsl:with-param name="memory" select="memory"/>
                            </xsl:call-template>
                          </a>
                        </li>
                        <li title="Current date/time" class="nav-item">
                          <a class="nav-link">
                            <xsl:value-of select="@date"/>
                          </a>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <script src="/io/surati/gap/web/base/js/jquery-3.5.1.min.js"/>
        <script src="/io/surati/gap/web/base/js/jquery-ui-1.13.1.min.js"/>
        <script src="/io/surati/gap/web/base/js/toastr-2.1.4.min.js"/>
        <script src="/io/surati/gap/web/base/js/popper-1.6.1.min.js"/>
        <script src="/io/surati/gap/web/base/js/angular-1.6.4.min.js"/>
        <script src="/io/surati/gap/web/base/js/main.js"/>
        <script src="/io/surati/gap/web/base/js/ui-bootstrap-tpls-3.0.4.min.js"/>
        <script type="text/javascript"><![CDATA[
		    	if (!String.prototype.format) {
		    		String.prototype.format = function() {
					  return [...arguments].reduce(
						  	(p,c) => {
						  	    if(c == undefined) {
						  	       return p.replace(/%s/,'');
						  	    } else {
						  	    	return p.replace(/%s/,c);
						  	    }
					  		},
					  		this
				  	  );
					};
		    	}
	    	    $(document).ready(function(){
				  $('[data-toggle="tooltip"]').tooltip();
				});				
				$('form').submit(function () {
				    $(this).find('input[type="checkbox"]').each( function () {
				        var checkbox = $(this);
				        if( checkbox.is(':checked')) {
				            checkbox.attr('value','true');
				        } else {
				            checkbox.after().append(checkbox.clone().attr({type:'hidden', value:'false'}));
				            checkbox.prop('disabled', true);
				        }
				    })
				});
			]]></script>
        <xsl:apply-templates select="." mode="custom-script"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
