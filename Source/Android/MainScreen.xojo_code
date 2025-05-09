#tag MobileScreen
Begin MobileScreen MainScreen
   Compatibility   =   ""
   Device          =   1
   HasBackButton   =   False
   HasNavigationBar=   True
   Modal           =   False
   Orientation     =   0
   Title           =   "Pawz"
   Begin MobileImageViewer PetViewer
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      DisplayMode     =   1
      Enabled         =   True
      Height          =   700
      Image           =   495319039
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      Top             =   0
      Visible         =   True
      Width           =   360
   End
   Begin URLConnection PicURL
      AllowCertificateValidation=   False
      FollowRedirects =   True
      Height          =   32
      HTTPStatusCode  =   0
      Left            =   40
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Password        =   ""
      Scope           =   2
      Top             =   50
      UserName        =   ""
      Width           =   32
   End
   Begin URLConnection PicDownload
      AllowCertificateValidation=   False
      FollowRedirects =   True
      Height          =   32
      HTTPStatusCode  =   0
      Left            =   60
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Password        =   ""
      Scope           =   2
      Top             =   70
      UserName        =   ""
      Width           =   32
   End
   Begin MobileSharingPanel SharePet
      Height          =   32
      Left            =   80
      LockedInPosition=   False
      PanelIndex      =   -1
      Parent          =   ""
      Scope           =   2
      Top             =   90
      Width           =   32
   End
End
#tag EndMobileScreen

#tag ScreenCode
	#tag Event
		Sub Opening()
		  Var catIcon As Picture = Picture.SystemImage("cat")
		  Var dogIcon As Picture = Picture.SystemImage("paw")
		  
		  Var catItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Cat", catIcon)
		  Var dogItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Dog", dogIcon)
		  
		  NavigationToolbar.AddButton(catItem)
		  NavigationToolbar.AddButton(dogItem)
		  
		  Var surpriseIcon As Picture = Picture.SystemImage("gift")
		  Var shareIcon As Picture = Picture.SystemImage("share")
		  
		  Var surpriseItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Surprise", surpriseIcon)
		  Var shareItem As New MobileToolbarButton(MobileToolbarButton.Types.Plain, "Share", shareIcon)
		  
		  Toolbar.AddButton(surpriseItem)
		  Toolbar.AddButton(shareItem)
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


	#tag Enum, Name = PicTypes, Flags = &h0
		Cat
		Dog
	#tag EndEnum


#tag EndScreenCode

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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
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
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="HasNavigationBar"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Modal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="NavigationBarHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackButton"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
