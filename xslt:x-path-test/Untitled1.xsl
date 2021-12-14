<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">

<xsl:template match="/source"></xsl:template>
<xsl:template match="/body"></xsl:template>
<xsl:template match="/event"></xsl:template>    
<xsl:template match="/item"></xsl:template>
<xsl:template match="/char"></xsl:template>
<xsl:template match="/place"></xsl:template>
    <xsl:template match="style">
        <HTML>
            <HEAD>
                <TITLE>Style</TITLE>
                <STYLE>
                    H1 {font-family: Times New Roman;
                    font-size: 36pt }
                </STYLE>
            </HEAD>
            <BODY><xsl:apply-templates/></BODY>
        </HTML>
    </xsl:template>
</xsl:stylesheet>

