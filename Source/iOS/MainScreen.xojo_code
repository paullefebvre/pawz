#tag MobileScreen
Begin MobileScreen MainScreen
   BackButtonCaption=   ""
   Compatibility   =   ""
   ControlCount    =   0
   Device = 7
   HasNavigationBar=   True
   LargeTitleDisplayMode=   2
   Left            =   0
   Orientation = 0
   ScaleFactor     =   0.0
   TabBarVisible   =   True
   TabIcon         =   0
   TintColor       =   &c000000
   Title           =   "Pawz"
   Top             =   0
   Begin URLConnection PicURL
      AllowCertificateValidation=   False
      FollowRedirects =   False
      Height          =   32
      Height          =   32
      HTTPStatusCode  =   0
      Left            =   80
      Left            =   80
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Scope           =   2
      Top             =   80
      Top             =   80
      Width           =   32
      Width           =   32
   End
   Begin URLConnection PicDownload
      AllowCertificateValidation=   False
      FollowRedirects =   False
      Height          =   32
      Height          =   32
      HTTPStatusCode  =   0
      Left            =   100
      Left            =   100
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Scope           =   2
      Top             =   100
      Top             =   100
      Width           =   32
      Width           =   32
   End
   Begin MobileImageViewer PetViewer
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   PetViewer, 1, <Parent>, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   PetViewer, 2, <Parent>, 2, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   PetViewer, 3, TopLayoutGuide, 4, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   PetViewer, 4, BottomLayoutGuide, 4, False, +1.00, 4, 1, 0, , True
      ControlCount    =   0
      DisplayMode     =   1
      Enabled         =   True
      Height          =   747
      Image           =   1381965823
      Left            =   0
      LockedInPosition=   False
      Scope           =   0
      TintColor       =   &c000000
      Top             =   65
      URL             =   ""
      Visible         =   True
      Width           =   375
      _ClosingFired   =   False
   End
   Begin MobileSharingPanel SharePet
      Height          =   32
      Height          =   32
      Left            =   140
      Left            =   140
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Scope           =   0
      Top             =   140
      Top             =   140
      Width           =   32
      Width           =   32
   End
End
#tag EndMobileScreen

#tag WindowCode
	#tag Event
		Sub Opening()
		  Var catIcon As Picture = Picture.SystemImage("cat", 16)
		  Var dogIcon As Picture = Picture.SystemImage("dog", 16)
		  
		  Var catItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Cat", catIcon)
		  Var dogItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Dog", dogIcon)
		  
		  LeftNavigationToolbar.AddButton(catItem)
		  LeftNavigationToolbar.AddButton(dogItem)
		  
		  Var surpriseIcon As Picture = Picture.SystemImage("gift", 16)
		  Var shareIcon As Picture = Picture.SystemImage("square.and.arrow.up", 16)
		  
		  Var surpriseItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Surprise", surpriseIcon)
		  Var shareItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Share", shareIcon)
		  
		  RightNavigationToolbar.AddButton(surpriseItem)
		  RightNavigationToolbar.AddButton(shareItem)
		End Sub
	#tag EndEvent

	#tag Event
		Sub ToolbarButtonPressed(button As MobileToolbarButton)
		  Select Case button.Caption
		  Case "Cat"
		    GetPic(PicTypes.Cat)
		    
		  Case "Dog"
		    GetPic(PicTypes.Dog)
		    
		  Case "Surprise"
		    If System.Random.InRange(1, 2) = 1 Then
		      GetPic(PicTypes.Cat)
		    Else
		      GetPic(PicTypes.Dog)
		    End If
		    
		  Case "Share"
		    If PetPic <> Nil Then
		      SharePet.SharePicture(PetPic)
		    End If
		    
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GetPic(type As PicTypes)
		  Var url As String
		  
		  Select Case type
		  Case PicTypes.Cat
		    url = "https://api.thecatapi.com"
		  Case PicTypes.Dog
		    url = "https://api.thedogapi.com"
		  End Select
		  
		  url = url + "/v1/images/search"
		  
		  PicURL.Send("GET", url)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private PetPic As Picture
	#tag EndProperty


	#tag Enum, Name = PicTypes, Type = Integer, Flags = &h0
		Cat
		Dog
	#tag EndEnum


#tag EndWindowCode

#tag Events PicURL
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  // Pull out the picture URL out of the JSON and download it.
		  
		  Var json As JSONItem = New JSONItem
		  json.Load(content)
		  
		  Var petItem As JSONItem
		  petItem = json.ValueAt(0)
		  
		  Var picURL As String
		  picURL = petItem.Value("url").StringValue
		  
		  PicDownload.Send("GET", picURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PicDownload
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  // The content is the binary picture data.
		  
		  PetPic = Picture.FromData(content)
		  PetViewer.Image = PetPic
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackButtonCaption"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasNavigationBar"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIcon"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LargeTitleDisplayMode"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="MobileScreen.LargeTitleDisplayModes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabBarVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TintColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScaleFactor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
