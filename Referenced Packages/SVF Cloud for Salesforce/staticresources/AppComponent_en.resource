<ComponentDefinition xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="AppComponent_Schema.xsd" version="1.0">
	<Title>SVF Cloud for Salesforce</Title>
	<Description>SVF Cloud AppComponent</Description>
	<Publisher>WingArc1st Inc.</Publisher>
	<PackageImage resourceName="SVFMenuImage"/>
	<WebSite>http://www.wingarc.com/</WebSite>
	<AppComponents>
		<AppComponent name="SVFCloudPrintButton">
			<Title>SVF Cloud Button</Title>
			<Description>SVF Cloud print button component.</Description>
			<HelpURL>https://www.wingarc-support.com/cloud/</HelpURL>
			<Layout>inline</Layout>
			<Height value="25" resizable="false"/>
			<Width value="80" resizable="true"/>
			<ComponentImage resourceName="SVFButtonImage"/>
			<CanvasImage resourceName="SVFCanvasButtonImage" stretch="Fill" />
			<PutablePlaces anyPlace="false">
				<Place name="canvas" />
				<Place name="pageBlock" />
				<Place name="pageBlockSection" />
				<Place name="pageBlockButtons" />
				<Place name="panelGrid" />
				<Place name="tab" />
				<Place name="displaySwitcher" />
			</PutablePlaces>
			<ApexComponent componentName="ButtonComponent">
				<ApexAttribute name="label" var="varlabel"/>
				<ApexAttribute name="buttonFullName" var="varButtonFullName"/>
				<ApexAttribute name="selectorId" var="varSelectorId"/>
				<ApexAttribute name="styleClass" var="varStyleClass"/>
				<ApexAttribute name="originalStyle" var="varOriginalStyle"/>
				<ApexAttribute name="width" var="Component__Width"/>
				<ApexAttribute name="PositionTop" var="Component__Top" />
				<ApexAttribute name="PositionLeft" var="Component__Left" />
			</ApexComponent>
			<Properties>
				<String name="varlabel" label="Label" maxLength="100" defaultValue="SVF 印刷" />
				<String name="varButtonFullName" label="SVF Button API Name" maxLength="254" isRequired="true" defaultValue="" />
				<IDSelector name="varSelectorId" label="IDSelector component Id" isRequired="false" />
				<StyleClass name="varStyleClass" label="style class" isRequired="false" isVisible="false" defaultValue="" />
				<String name="varOriginalStyle" label="style" maxLength="255" defaultValue="" />
			</Properties>
		</AppComponent>
	</AppComponents>
</ComponentDefinition>