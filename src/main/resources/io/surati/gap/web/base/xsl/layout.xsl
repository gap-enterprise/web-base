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
                  <img src="/img/logo.png" style="height:50px;"/>
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
                  <li class="dropdown nav-item">
                    <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false"><i class="nav-link-icon lnr-diamond"/> Paiements
                                <i class="fa fa-angle-down ml-2 opacity-5"/>
                            </a>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                      <div class="dropdown-menu-header">
                        <div class="dropdown-menu-header-inner bg-success">
                          <div class="menu-header-image opacity-1" style="background-image: url('/img/abstract.jpg');"/>
                          <div class="menu-header-content text-left">
                            <h5 class="menu-header-title">Paiements</h5>
                            <h6 class="menu-header-subtitle">Effectuer vos paiements</h6>
                          </div>
                        </div>
                      </div>
                      <xsl:if test="sec:hasAccess(.,'IMPORTER_ORDRES_PAIEMENT')">
                        <a href="/reference-document/list" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-pointer-left"/>Documents de référence à traiter
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') or sec:hasAccess(.,'AUTORISER_ORDRES_PAIEMENT')">
                        <a href="/payment-order/to-prepare" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-pointer-left"/>Ordres de paiement à préparer
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
                        <a href="/payment/home" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-diamond"> </i>Paiements à exécuter
	                                </a>
                        <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
                          <a href="/payment/export/list" tabindex="0" class="dropdown-item"><i class="dropdown-icon fa fa-upload"> </i>Paiements à exporter
		                                </a>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_CARNETS') or sec:hasAccess(.,'PREPARER_CARNETS') or sec:hasAccess(.,'METTRE_EN_UTILISATION_CARNETS') or sec:hasAccess(.,'BLOQUER_CARNETS')">
                        <div tabindex="-1" class="dropdown-divider"/>
                        <a href="/bank-note-book" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-book"> </i>Mes carnets de formule
	                                </a>
                      </xsl:if>
                    </div>
                  </li>
                  <li class="dropdown nav-item">
                    <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false"><i class="nav-link-icon lnr-diamond"/> Compte de gestion
                                <i class="fa fa-angle-down ml-2 opacity-5"/>
                            </a>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                      <div class="dropdown-menu-header">
                        <div class="dropdown-menu-header-inner bg-success">
                          <div class="menu-header-image opacity-1" style="background-image: url('/img/abstract.jpg');"/>
                          <div class="menu-header-content text-left">
                            <h5 class="menu-header-title">Compte de gestion</h5>
                            <h6 class="menu-header-subtitle">Suivre l'exécution des dépenses</h6>
                          </div>
                        </div>
                      </div>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_DOCUMENTS_A_ENLIASER')">
                        <a href="/maccount/document-to-bundle/entire/list" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-pointer-left"/>Documents non fractionnés à enliasser
                                </a>
                        <a href="/maccount/document-to-bundle/partial/list" tabindex="1" class="dropdown-item"><i class="dropdown-icon lnr-pointer-left"/>Documents fractionnés à enliasser
                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'CONFIGURER_LIASSES')">
                        <div tabindex="-1" class="dropdown-divider"/>
                        <a href="/maccount/bundle" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-book"> </i>Configurer les liasses
                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'CONFIGURER_TITRES')">
                        <a href="/maccount/title" tabindex="1" class="dropdown-item"><i class="dropdown-icon lnr-book"> </i>Configurer les titres
                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'CONFIGURER_SECTIONS')">
                        <a href="/maccount/section" tabindex="2" class="dropdown-item"><i class="dropdown-icon lnr-book"> </i>Configurer les sections
                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'CONFIGURER_SEUILS_ENLIASSEMENT')">
                        <a href="/maccount/bundle-threshold/view" tabindex="3" class="dropdown-item"><i class="dropdown-icon lnr-book"> </i>Configurer les seuils d'enliassement
                                    </a>
                      </xsl:if>
                    </div>
                  </li>
                  <li class="dropdown nav-item">
                    <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false"><i class="nav-link-icon lnr-history"/> Historique
                                <i class="fa fa-angle-down ml-2 opacity-5"/>
                            </a>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                      <div class="dropdown-menu-header">
                        <div class="dropdown-menu-header-inner bg-warning">
                          <div class="menu-header-image opacity-1" style="background-image: url('/img/abstract.jpg');"/>
                          <div class="menu-header-content text-left">
                            <h5 class="menu-header-title">Historique</h5>
                            <h6 class="menu-header-subtitle">Explorer vos données de production</h6>
                          </div>
                        </div>
                      </div>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_ORDRES_PAIEMENT') or sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') or sec:hasAccess(.,'AUTORISER_ORDRES_PAIEMENT')">
                        <a href="/payment-order" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-pointer-left"/>Ordres de paiement
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_PAIEMENTS')">
                        <a href="/payment/list" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-diamond"> </i>Paiements
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_DOCUMENT_REF') or sec:hasAccess(.,'EDITER_DOCUMENT_REF')">
                        <a href="/reference-document/history" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-briefcase"> </i>Documents de référence
	                                </a>
                      </xsl:if>
                    </div>
                  </li>
                  <li class="dropdown nav-item">
                    <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false"><i class="nav-link-icon lnr-cog"/> Paramétrage
                                <i class="fa fa-angle-down ml-2 opacity-5"/>
                            </a>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                      <div class="dropdown-menu-header">
                        <div class="dropdown-menu-header-inner bg-info">
                          <div class="menu-header-image opacity-1" style="background-image: url('/img/abstract.jpg');"/>
                          <div class="menu-header-content text-left">
                            <h5 class="menu-header-title">Paramétrage</h5>
                            <h6 class="menu-header-subtitle">Paramétrer vos données de base</h6>
                          </div>
                        </div>
                      </div>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_BANQUES') or sec:hasAccess(.,'CONFIGURER_BANQUES')">
                        <a href="/bank" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-apartment"> </i>Banques
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_COMPTES_BANCAIRES') or sec:hasAccess(.,'CONFIGURER_COMPTES_BANCAIRES')">
                        <a href="/bank-account" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-inbox"> </i>Mes comptes bancaires
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_TIERS') or sec:hasAccess(.,'CONFIGURER_TIERS')">
                        <a href="/third-party-family" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-database"> </i>Familles de tiers
	                                </a>
                        <a href="/third-party" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-users"> </i>Tiers
	                                </a>
                      </xsl:if>
                    </div>
                  </li>
                  <li class="dropdown nav-item">
                    <a aria-haspopup="true" data-toggle="dropdown" class="nav-link" aria-expanded="false"><i class="nav-link-icon lnr-cog"/> Administration
                                <i class="fa fa-angle-down ml-2 opacity-5"/>
                            </a>
                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu-rounded dropdown-menu-lg rm-pointers dropdown-menu">
                      <div class="dropdown-menu-header">
                        <div class="dropdown-menu-header-inner bg-danger">
                          <div class="menu-header-image opacity-1" style="background-image: url('/img/abstract.jpg');"/>
                          <div class="menu-header-content text-left">
                            <h5 class="menu-header-title">Administration</h5>
                            <h6 class="menu-header-subtitle">Gérer la sécurité, l'audit, etc.</h6>
                          </div>
                        </div>
                      </div>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_UTILISATEURS') or sec:hasAccess(.,'CONFIGURER_UTILISATEURS') or sec:hasAccess(.,'BLOQUER_UTILISATEURS') or sec:hasAccess(.,'CHANGER_MOT_DE_PASSE_UTILISATEURS')">
                        <a href="/user" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-user"> </i>Utilisateurs
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_PROFILS') or sec:hasAccess(.,'CONFIGURER_PROFILS')">
                        <a href="/profile" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-license"> </i>Profils
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_INFO_ENTREPRISE') or sec:hasAccess(.,'CONFIGURER_INFO_ENTREPRISE')">
                        <a href="/enterprise" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-database"> </i>Entreprise
	                                </a>
                      </xsl:if>
                      <xsl:if test="sec:hasAccess(.,'VISUALISER_LA_JOURNALISATION')">
                        <a href="/event-log" tabindex="0" class="dropdown-item"><i class="dropdown-icon lnr-layers"> </i>Journalisation
	                                </a>
                      </xsl:if>
                    </div>
                  </li>
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
                    <li class="app-sidebar__heading">Paiements</li>
                    <li class="">
                      <a class="menu-size" href="#"><i class="metismenu-icon lnr-diamond"/> Effectuer vos paiements
                                    <i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                                </a>
                      <ul>
                        <xsl:if test="sec:hasAccess(.,'IMPORTER_ORDRES_PAIEMENT')">
                          <li>
                            <a class="menu-size" href="/reference-document/list"><i class="metismenu-icon"/>Docs de référence à traiter
                                        </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') or sec:hasAccess(.,'AUTORISER_ORDRES_PAIEMENT')">
                          <li>
                            <a href="/payment-order/to-prepare" tabindex="0" class="menu-size"><i class="metismenu-icon"/>Ordres paiement à préparer
		                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
                          <li>
                            <a href="/payment/home" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Paiements à exécuter
	                                </a>
                          </li>
                          <xsl:if test="sec:hasAccess(.,'EXECUTER_ORDRES_PAIEMENT')">
                            <li>
                              <a href="/payment/export/list" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Paiements à exporter
                                </a>
                            </li>
                          </xsl:if>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_CARNETS') or sec:hasAccess(.,'PREPARER_CARNETS') or sec:hasAccess(.,'METTRE_EN_UTILISATION_CARNETS') or sec:hasAccess(.,'BLOQUER_CARNETS')">
                          <div tabindex="-1" class="dropdown-divider"/>
                          <li>
                            <a href="/bank-note-book" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Mes carnets de formule
                                </a>
                          </li>
                        </xsl:if>
                      </ul>
                    </li>
                    <li class="app-sidebar__heading">Compte de gestion</li>
                    <li class="">
                      <a class="menu-size" href="#"><i class="metismenu-icon lnr-diamond"/> Suivre l'exécution des dépenses
                                    <i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                                </a>
                      <ul>
                        <li>
                          <a class="menu-size" href="/maccount/document-to-bundle/entire/list"><i class="metismenu-icon"/>Documents non fractionnés à enliasser
                                        </a>
                        </li>
                        <li>
                          <a class="menu-size" href="/maccount/document-to-bundle/partial/list"><i class="metismenu-icon"/>Documents fractionnés à enliasser
                                        </a>
                        </li>
                        <xsl:if test="sec:hasAccess(.,'CONFIGURER_LIASSES')">
                          <div tabindex="-1" class="dropdown-divider"/>
                          <li>
                            <a href="/maccount/bundle" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i> Configurer les liasses
                                        </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'CONFIGURER_TITRES')">
                          <li>
                            <a href="/maccount/title" tabindex="1" class="menu-size"><i class="metismenu-icon"> </i> Configurer les titres
                                        </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'CONFIGURER_SECTIONS')">
                          <li>
                            <a href="/maccount/section" tabindex="2" class="menu-size"><i class="metismenu-icon"> </i> Configurer les sections
                                        </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'CONFIGURER_SEUILS_ENLIASSEMENT')">
                          <li>
                            <a href="/maccount/bundle-threshold/view" tabindex="3" class="menu-size"><i class="metismenu-icon"> </i> Configurer les seuils d'enliassement
                                            </a>
                          </li>
                        </xsl:if>
                      </ul>
                    </li>
                    <li class="app-sidebar__heading"> Historique</li>
                    <li>
                      <a class="menu-size" href="#"><i class="metismenu-icon lnr-history"/> Explorer données production
                                    <i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                                </a>
                      <ul>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_ORDRES_PAIEMENT') or sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') or sec:hasAccess(.,'AUTORISER_ORDRES_PAIEMENT')">
                          <li>
                            <a href="/payment-order" tabindex="0" class="menu-size"><i class="metismenu-icon"/>Ordres de paiement
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_PAIEMENTS')">
                          <li>
                            <a href="/payment/list" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Paiements
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_DOCUMENT_REF') or sec:hasAccess(.,'EDITER_DOCUMENT_REF')">
                          <li>
                            <a href="/reference-document/history" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Documents de référence
	                                </a>
                          </li>
                        </xsl:if>
                      </ul>
                    </li>
                    <li class="app-sidebar__heading">Paramétrage</li>
                    <li>
                      <a class="menu-size" href="#"><i class="metismenu-icon lnr-cog"/>Paramétrer données de base
									<i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                                </a>
                      <ul>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_BANQUES') or sec:hasAccess(.,'CONFIGURER_BANQUES')">
                          <li>
                            <a href="/bank" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Banques
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_COMPTES_BANCAIRES') or sec:hasAccess(.,'CONFIGURER_COMPTES_BANCAIRES')">
                          <li>
                            <a href="/bank-account" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Mes comptes bancaires
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_TIERS') or sec:hasAccess(.,'CONFIGURER_TIERS')">
                          <li>
                            <a href="/third-party-family" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Familles de tiers
	                                </a>
                          </li>
                          <li>
                            <a href="/third-party" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Tiers
	                                </a>
                          </li>
                        </xsl:if>
                      </ul>
                    </li>
                    <li class="app-sidebar__heading">Administration</li>
                    <li>
                      <a class="menu-size" href="#"><i class="metismenu-icon lnr-cog"/> Gérer la sécurité, l'audit, etc.
                                    <i class="metismenu-state-icon fa fa-angle-down caret-left"/>
                                </a>
                      <ul>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_UTILISATEURS') or sec:hasAccess(.,'CONFIGURER_UTILISATEURS') or sec:hasAccess(.,'BLOQUER_UTILISATEURS') or sec:hasAccess(.,'CHANGER_MOT_DE_PASSE_UTILISATEURS')">
                          <li>
                            <a href="/user" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Utilisateurs
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_PROFILS') or sec:hasAccess(.,'CONFIGURER_PROFILS')">
                          <li>
                            <a href="/profile" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Profils
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_INFO_ENTREPRISE') or sec:hasAccess(.,'CONFIGURER_INFO_ENTREPRISE')">
                          <li>
                            <a href="/enterprise" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Entreprise
	                                </a>
                          </li>
                        </xsl:if>
                        <xsl:if test="sec:hasAccess(.,'VISUALISER_LA_JOURNALISATION')">
                          <li>
                            <a href="/event-log" tabindex="0" class="menu-size"><i class="metismenu-icon"> </i>Journalisation
	                                </a>
                          </li>
                        </xsl:if>
                      </ul>
                    </li>
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
                                  <div class="scrollbar-container">
                                                           
                                                        </div>
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
