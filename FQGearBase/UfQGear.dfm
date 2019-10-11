object fP: TfP
  Left = 0
  Top = 0
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'FQGear [OMG]'
  ClientHeight = 837
  ClientWidth = 1368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1368
    Height = 837
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel1: TPanel
      Left = 7
      Top = 38
      Width = 1354
      Height = 791
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PanelConsole: TPanel
        Left = 0
        Top = 209
        Width = 1354
        Height = 582
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 367
          Top = 0
          Width = 6
          Height = 582
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          MinSize = 100
          ExplicitHeight = 497
        end
        object Panel21: TPanel
          Left = 0
          Top = 0
          Width = 367
          Height = 582
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Splitter6: TSplitter
            Left = 0
            Top = 238
            Width = 367
            Height = 7
            Cursor = crVSplit
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            ExplicitTop = 153
          end
          object Panel28: TPanel
            Left = 0
            Top = 458
            Width = 367
            Height = 124
            Align = alBottom
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            Visible = False
            DesignSize = (
              367
              124)
            object RSection: TComboBox
              Left = 8
              Top = 9
              Width = 350
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Style = csOwnerDrawFixed
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object RParams: TComboBox
              Left = 8
              Top = 41
              Width = 350
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 1
            end
            object Button5: TButton
              Left = 7
              Top = 76
              Width = 353
              Height = 42
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Anchors = [akLeft, akTop, akRight]
              Caption = #161'Run!'
              TabOrder = 2
              OnClick = Button5Click
            end
          end
          object ListStack: TListView
            Left = 0
            Top = 0
            Width = 367
            Height = 238
            Align = alClient
            Columns = <
              item
                Caption = 'PID'
                Width = 78
              end
              item
                Caption = 'Stat'
                Width = 72
              end
              item
                Caption = 'Function'
                Width = 99
              end
              item
                Caption = 'Parameters'
                Width = 150
              end
              item
                Caption = 'Result'
                Width = 78
              end
              item
                Caption = 'Run Time'
                Width = 150
              end
              item
                Caption = 'At'
                Width = 157
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 1
            ViewStyle = vsReport
          end
          object Panel29: TPanel
            Left = 0
            Top = 450
            Width = 367
            Height = 8
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
            Visible = False
          end
          object ListVar: TListView
            Left = 0
            Top = 245
            Width = 367
            Height = 205
            Align = alBottom
            Columns = <
              item
                Caption = 'Item'
                Width = 99
              end
              item
                Caption = 'Value'
                Width = 150
              end
              item
                Caption = 'Flow PID'
                Width = 78
              end
              item
                Caption = 'Last Change'
                Width = 92
              end
              item
                Caption = 'At'
                Width = 157
              end>
            ReadOnly = True
            RowSelect = True
            TabOrder = 3
            ViewStyle = vsReport
          end
        end
        object Panel6: TPanel
          Left = 373
          Top = 0
          Width = 981
          Height = 582
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Splitter2: TSplitter
            Left = 0
            Top = 216
            Width = 981
            Height = 6
            Cursor = crVSplit
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            ExplicitTop = 130
          end
          object Panel16: TPanel
            Left = 0
            Top = 0
            Width = 981
            Height = 216
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object RichConsole: TRichEdit
              Left = 0
              Top = 40
              Width = 981
              Height = 176
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
              Zoom = 100
            end
            object ToolBar1: TToolBar
              Left = 0
              Top = 0
              Width = 981
              Height = 36
              ButtonHeight = 33
              ButtonWidth = 36
              Caption = 'ToolBar1'
              Images = ImageList1
              TabOrder = 1
              object ToolButton9: TToolButton
                Left = 0
                Top = 0
                Caption = 'ToolButton9'
                ImageIndex = 7
                OnClick = ToolButton9Click
              end
              object ToolButton10: TToolButton
                Left = 36
                Top = 0
                Width = 8
                Caption = 'ToolButton10'
                ImageIndex = 6
                Style = tbsSeparator
              end
              object ToolButton7: TToolButton
                Left = 44
                Top = 0
                Caption = 'ToolButton7'
                ImageIndex = 6
                OnClick = ClearAllLog1Click
              end
              object ToolButton8: TToolButton
                Left = 80
                Top = 0
                Width = 8
                Caption = 'ToolButton8'
                ImageIndex = 6
                Style = tbsSeparator
              end
              object ToolButton1: TToolButton
                Left = 88
                Top = 0
                Caption = 'ToolButton1'
                ImageIndex = 0
                OnClick = ClearCode1Click
              end
              object ToolButton3: TToolButton
                Left = 124
                Top = 0
                Caption = 'ToolButton3'
                Enabled = False
                ImageIndex = 1
                OnClick = ToolButton3Click
              end
              object ToolButton4: TToolButton
                Left = 160
                Top = 0
                Width = 8
                Caption = 'ToolButton4'
                ImageIndex = 2
                Style = tbsSeparator
              end
              object ToolPlay: TToolButton
                Left = 168
                Top = 0
                Caption = 'ToolPlay'
                Down = True
                ImageIndex = 3
                OnClick = ToolStopClick
              end
              object ToolStop: TToolButton
                Left = 204
                Top = 0
                Caption = 'ToolStop'
                ImageIndex = 2
                OnClick = ToolStopClick
              end
              object ToolButton13: TToolButton
                Left = 240
                Top = 0
                Width = 8
                Caption = 'ToolButton13'
                ImageIndex = 9
                Style = tbsSeparator
              end
              object ToolPause: TToolButton
                Left = 248
                Top = 0
                AllowAllUp = True
                Caption = 'ToolPause'
                ImageIndex = 9
                Style = tbsCheck
                OnClick = ToolPauseClick
              end
              object ToolButton2: TToolButton
                Left = 284
                Top = 0
                Width = 8
                Caption = 'ToolButton2'
                ImageIndex = 3
                Style = tbsSeparator
              end
              object ToolButton5: TToolButton
                Left = 292
                Top = 0
                Caption = 'ToolButton5'
                Enabled = False
                ImageIndex = 4
                OnClick = ReloadScriptfromHTTP1Click
              end
              object ToolButton6: TToolButton
                Left = 328
                Top = 0
                Caption = 'ToolButton6'
                Enabled = False
                ImageIndex = 5
                OnClick = LoadScriptfromHTTPNoreset1Click
              end
              object ToolButton12: TToolButton
                Left = 364
                Top = 0
                Width = 8
                Caption = 'ToolButton12'
                ImageIndex = 7
                Style = tbsSeparator
              end
              object ToolButton11: TToolButton
                Left = 372
                Top = 0
                Caption = 'ToolButton11'
                Enabled = False
                ImageIndex = 8
                OnClick = ToolButton11Click
              end
            end
            object Panel10: TPanel
              Left = 0
              Top = 36
              Width = 981
              Height = 4
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 222
            Width = 981
            Height = 360
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 981
              Height = 360
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object Panel22: TPanel
                Left = 0
                Top = 0
                Width = 981
                Height = 360
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object Panel23: TPanel
                  Left = 0
                  Top = 320
                  Width = 981
                  Height = 4
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alBottom
                  BevelOuter = bvNone
                  TabOrder = 1
                end
                object Panel24: TPanel
                  Left = 0
                  Top = 324
                  Width = 981
                  Height = 36
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alBottom
                  BevelOuter = bvNone
                  TabOrder = 2
                  object Button1: TButton
                    Left = 850
                    Top = 0
                    Width = 131
                    Height = 36
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                    Align = alRight
                    Caption = #161'Run!'
                    TabOrder = 0
                    OnClick = Button1Click
                  end
                  object Panel25: TPanel
                    Left = 842
                    Top = 0
                    Width = 8
                    Height = 36
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                    Align = alRight
                    BevelOuter = bvNone
                    TabOrder = 1
                  end
                  object Panel26: TPanel
                    Left = 0
                    Top = 0
                    Width = 842
                    Height = 36
                    Margins.Left = 4
                    Margins.Top = 4
                    Margins.Right = 4
                    Margins.Bottom = 4
                    Align = alClient
                    BevelOuter = bvNone
                    TabOrder = 2
                    object SParams: TComboBox
                      Left = 0
                      Top = 4
                      Width = 842
                      Height = 25
                      Margins.Left = 4
                      Margins.Top = 4
                      Margins.Right = 4
                      Margins.Bottom = 4
                      Align = alClient
                      TabOrder = 0
                    end
                    object Panel27: TPanel
                      Left = 0
                      Top = 0
                      Width = 842
                      Height = 4
                      Margins.Left = 4
                      Margins.Top = 4
                      Margins.Right = 4
                      Margins.Bottom = 4
                      Align = alTop
                      BevelOuter = bvNone
                      TabOrder = 1
                    end
                  end
                end
                object Memorun: TSynEdit
                  Left = 0
                  Top = 0
                  Width = 981
                  Height = 320
                  Margins.Left = 4
                  Margins.Top = 4
                  Margins.Right = 4
                  Margins.Bottom = 4
                  Align = alClient
                  ActiveLineColor = 15138811
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -17
                  Font.Name = 'Courier New'
                  Font.Style = []
                  TabOrder = 0
                  OnKeyDown = MemorunKeyDown
                  BookMarkOptions.LeftMargin = 3
                  Gutter.Color = 15703301
                  Gutter.DigitCount = 3
                  Gutter.Font.Charset = DEFAULT_CHARSET
                  Gutter.Font.Color = clWhite
                  Gutter.Font.Height = -11
                  Gutter.Font.Name = 'Courier New'
                  Gutter.Font.Style = []
                  Gutter.RightOffset = 15
                  Gutter.ShowLineNumbers = True
                  Gutter.Width = 10
                  Highlighter = SynFQSyn1
                  Options = [eoDragDropEditing, eoDropFiles, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces, eoTrimTrailingSpaces]
                  RightEdgeColor = clBtnFace
                  TabWidth = 4
                  WantTabs = True
                  OnDropFiles = MemorunDropFiles
                  FontSmoothing = fsmNone
                end
              end
            end
          end
        end
      end
      object PanelScript: TPanel
        Left = 0
        Top = 0
        Width = 1354
        Height = 209
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Splitter3: TSplitter
          Left = 621
          Top = 0
          Width = 5
          Height = 209
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitHeight = 294
        end
        object Splitter4: TSplitter
          Left = 326
          Top = 0
          Width = 5
          Height = 209
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ExplicitHeight = 294
        end
        object Panel12: TPanel
          Left = 0
          Top = 0
          Width = 326
          Height = 209
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          object Splitter5: TSplitter
            Left = 0
            Top = -105
            Width = 326
            Height = 7
            Cursor = crVSplit
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            ExplicitTop = -20
          end
          object MemoScript: TMemo
            Left = 0
            Top = 0
            Width = 326
            Height = 7
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssVertical
            TabOrder = 0
            WantReturns = False
            OnChange = MemoScriptChange
          end
          object Panel8: TPanel
            Left = 0
            Top = 157
            Width = 326
            Height = 52
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
            DesignSize = (
              326
              52)
            object Button4: TButton
              Left = 116
              Top = 8
              Width = 95
              Height = 35
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'HTTP Get'
              TabOrder = 0
              OnClick = Button4Click
            end
            object ComboPath: TComboBox
              Left = 9
              Top = 13
              Width = 99
              Height = 25
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 1
              Items.Strings = (
                'fqdev')
            end
            object Button2: TButton
              Left = 217
              Top = 8
              Width = 99
              Height = 35
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Load'
              TabOrder = 2
              OnClick = Button2Click
            end
          end
          object Panel15: TPanel
            Left = 0
            Top = 150
            Width = 326
            Height = 7
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 2
          end
          object MemoFQ: TMemo
            Left = 0
            Top = -98
            Width = 326
            Height = 248
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            BevelInner = bvNone
            BevelOuter = bvNone
            ScrollBars = ssVertical
            TabOrder = 3
            WantReturns = False
            OnChange = MemoFQChange
          end
        end
        object Panel9: TPanel
          Left = 331
          Top = 0
          Width = 290
          Height = 209
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          object Panel13: TPanel
            Left = 0
            Top = 30
            Width = 290
            Height = 179
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'Panel13'
            TabOrder = 0
            object WebScript: TWebBrowser
              Left = 2
              Top = 2
              Width = 286
              Height = 175
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Align = alClient
              TabOrder = 0
              OnDocumentComplete = WebScriptDocumentComplete
              ExplicitWidth = 273
              ExplicitHeight = 248
              ControlData = {
                4C000000A6170000780E00000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E12620E000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
          object Panel19: TPanel
            Left = 0
            Top = 0
            Width = 290
            Height = 30
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            BevelOuter = bvLowered
            Caption = 'Input Script'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object Panel17: TPanel
          Left = 626
          Top = 0
          Width = 728
          Height = 209
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          object Panel18: TPanel
            Left = 0
            Top = 30
            Width = 728
            Height = 179
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'Panel13'
            TabOrder = 0
            object WebFQ: TWebBrowser
              Left = 2
              Top = 2
              Width = 724
              Height = 175
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Align = alClient
              TabOrder = 0
              OnDocumentComplete = WebFQDocumentComplete
              ExplicitWidth = 691
              ExplicitHeight = 248
              ControlData = {
                4C000000DD3B0000780E00000000000000000000000000000000000000000000
                000000004C000000000000000000000001000000E0D057007335CF11AE690800
                2B2E12620E000000000000004C0000000114020000000000C000000000000046
                8000000000000000000000000000000000000000000000000000000000000000
                00000000000000000100000000000000000000000000000000000000}
            end
          end
          object Panel20: TPanel
            Left = 0
            Top = 0
            Width = 728
            Height = 30
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            BevelOuter = bvLowered
            Caption = 'RAW Script'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
    end
    object Panel7: TPanel
      Left = 1361
      Top = 38
      Width = 7
      Height = 791
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
    end
    object Panel14: TPanel
      Left = 0
      Top = 0
      Width = 1368
      Height = 38
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel14'
      TabOrder = 2
      DesignSize = (
        1368
        38)
      object TabMain: TTabControl
        Left = 3
        Top = 5
        Width = 1352
        Height = 33
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Anchors = [akLeft, akTop, akRight]
        Style = tsFlatButtons
        TabOrder = 0
        Tabs.Strings = (
          'Script'
          'Console')
        TabIndex = 1
        TabWidth = 100
        OnChange = TabMainChange
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 38
      Width = 7
      Height = 791
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
    end
    object Panel4: TPanel
      Left = 0
      Top = 829
      Width = 1368
      Height = 8
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 4
    end
  end
  object TimerCreateDelay: TTimer
    Enabled = False
    Interval = 3
    OnTimer = TimerCreateDelayTimer
    Left = 927
    Top = 30
  end
  object IdIOHandlerStack1: TIdIOHandlerStack
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    Left = 761
    Top = 30
  end
  object IdHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.AcceptLanguage = 'en_US'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 817
    Top = 30
  end
  object ImageList1: TImageList
    BlendColor = clBtnFace
    BkColor = 15790320
    Height = 24
    Width = 24
    Left = 871
    Top = 30
    Bitmap = {
      494C01010B0024002C0418001800F0F0F000FF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000480000000100200000000000006C
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F0007DCDEF0035AEE5000096
      DB000090D70035A3DC007DC1E700F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000E1E1E100C5C5C500ACACAC009B9B
      9B0098989800A7A7A700BEBEBE00DDDDDD00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000E5ECEF0077C5E80033ABE2000096
      DB000090D70033A0D90077BADF00E5EBEE00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000B9E6F80020ACE70074CBEF009FDEF500A1E3
      F7009DE1F7009ADAF30074C0E8002096D600B6DCF100F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000D5D5D500B5B5B500CECECE00E6E6E600F5F5
      F500F2F2F200DDDDDD00BFBFBF00A1A1A100C9C9C900F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000AFDBED001FAAE60074CBEF009FDEF500A1E3
      F7009DE1F7009ADAF30074C0E8001F95D400ACD1E600F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000AAE3F80044BDEE0096DCF60089DFF60054CEF2003AC4
      EF0032C0EE003FC4EF006FD2F20091D2EF0047A9DE00AAD6EF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DBDBDB00BBBBBB00ECECEC00FEFEFE00F3F3F300E8E8
      E800E7E7E700F1F1F100FBFBFB00E1E1E1009D9D9D00CACACA00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000A1D8EE0044BDEE0096DCF60089DFF60054CEF2003AC4
      EF0032C0EE003FC4EF006FD2F20091D2EF0047A9DE00A1CCE400F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0000CAEED00A2E2F8007BDDF60052D1F30042CBF1003BC7
      F00033C2EE002BBEED002BBCED004FC8F00096D6F1000C8FD400F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E8E8E800CACACA00F0F0F000FFFFFF00EFEFEF00EFEFEF00EFEF
      EF00E3E3E300EDEDED00EDEDED00FBFBFB00E2E2E200A6A6A600DEDEDE00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DCEAF0000BADEC00A2E2F8007BDDF6005CD2F200A7E2F500DAF2
      FA00D7F1FA0099DCF30034BEED004FC8F00096D6F1000B8ED300DCE7ED00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0007AD6F7007DD6F60095E6F8005ED7F4004AC5E8002A90BA001F81
      AC001A7EAC001B87B70025B1E20028BBED0067CFF2007DC7EB007AC2E800F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DFDFDF00E4E4E400FEFEFE00E8E8E8008887870087878700E5E5
      E500E5E5E5008686860086858500EDEDED00FBFBFB00C5C5C500C4C4C400F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00074CEF0007DD6F60095E6F8006AD6F200E0F1F800FEFFFF00FFFF
      FF00FFFFFF00FEFFFF00D5ECF70035BDEC0067CFF2007DC7EB0074BCE100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0002FBFF400AEEAFB0077E0F70056CCEA002988AF003CB0D60046CC
      F1003FC9F0002AA6D200167BAB0023B1E20038C0EE009CDBF4002FA6DF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D9D9D900F2F2F200F5F5F500E9E9E9007474740088888800E7E7
      E700E6E6E6007272720087868600EEEEEE00F2F2F200E1E1E100B1B1B100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0002DBDF200AEEAFB0077E0F700A9DDF000FAFBFD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F8FAFC008BD1EC0038C0EE009CDBF4002DA3DD00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000FB8F500B7EFFB0071E0F7002F8CB10046B3D50054D4F3004DCF
      F20044CBF1003BC8F00027A2D000157AAB002EBEED0098DEF6000C9DDF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D5D5D500FCFCFC00EFEFEF00EBEBEB007574740089888800E9E9
      E900E8E8E8007372720087868600EFEFEF00E8E8E800F4F4F400A7A7A700F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0000EB8F400B7EFFB0071E0F700B2D1E500D6E4EF00D9E6F000D9E6
      F000D9E6F000D9E6F000D6E4EF00A6CDE4002EBEED0098DEF6000B9CDE00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00006B8F500BFF3FC0075E3F70069DEF60062DAF5005AD7F40052D2
      F3004ACEF20042CBF1003AC5EF0031C1EE0033C0EE0099DFF6000FA0E100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D6D6D600FCFCFC00F0F0F000EDEDED007574740089898900E9E9
      E900E9E9E9007473730088878700EFEFEF00E9E9E900FAFAFA00ABABAB00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00006B7F500BFF3FC0075E3F7007FB1D3008CB2D3008CB3D3008CB3
      D3008CB3D3008CB3D3008BB2D30079AED20033C0EE0099DFF6000E9FE000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0002FC5F900B1ECFC0085E7F9006EE0F70067DDF6005FD9F50058D6
      F40050D1F30047CDF2003FCAF00037C4EF0047C8F000A0DFF6002FAFE700F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DCDCDC00F5F5F500F7F7F700EDEDED00767575008A8A8A00EBEB
      EB00EAEAEA007474740089888800F0F0F000F4F4F400EEEEEE00BBBBBB00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0002DC3F600B1ECFC0085E7F9006EE0F70067DDF6005FD9F50058D6
      F40050D1F30047CDF2003FCAF00037C4EF0047C8F000A0DFF6002DADE500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F0007ADCFC007ADBFB00A6EFFB0077E4F8006CDFF700568EB4005DD8
      F50055D4F400538DB40046CCF10043CAF0007AD8F4007ACFF2007ACEF100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E3E3E300EBEBEB00FFFFFF00EFEFEF00767676008B8A8A00EDED
      ED00ECECEC007574740089888800F1F1F100FFFFFF00DDDDDD00D1D1D100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00074D4F5007ADBFB00A6EFFB0077E4F800568EB4005FD9F5005DD8
      F50055CDF00047CDF200538DB40043CAF0007AD8F4007ACFF20074C7EA00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0000CBEF900A6E9FC0098EBFA0077E3F7006ADEF70063DA
      F5005BD7F40053D3F30052D1F30070D8F4009DDFF7000CA9E900F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EBEBEB00DCDCDC00F8F8F800FFFFFF00EFEFEF00EEEEEE00EDED
      ED00EDEDED00ECECEC00EBEBEB00FFFFFF00F5F5F500C7C7C700E6E6E600F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DFECF1000BBDF900A6E9FC0098EBFA0077E3F70066CAE600568F
      B500568EB40054ADD20052D1F30070D8F4009DDFF7000BA9E800DFEBEF00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000ADEAFE003ECDFA0099E5FC00A8EFFB0080E5F8006DDE
      F60065DAF5006DDBF50091E3F70093DEF8003EBFF100ADE4F800F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E7E7E700D9D9D900F8F8F800FFFFFF00F8F8F800F2F2
      F200F1F1F100F7F7F700FFFFFF00F5F5F500CBCBCB00DFDFDF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000A4DFF3003ECDFA0099E5FC00A0E7F30062A7C80065C0
      DE0061CDE9005DA3C7007CC4DF0093DEF8003EBFF100A4D9EE00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000BFEFFE0020C4FB0074DAFB00AAEAFC00BCF0
      FB00B9EFFB00A5E6FA0074D5F70020B9F200BFEBFB00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000E7E7E700DCDCDC00EBEBEB00F5F5F500FCFC
      FC00FCFCFC00F4F4F400E8E8E800D4D4D400E1E1E100F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000B5E3F3001FC2F90074DAFB00AAEAFC00BCF0
      FB00B9EFFB00A5E6FA0074D5F7001FB7F000B5DFF000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F00080DEFD0038CAFA0003B9
      F70003B8F60038C5F70080DAF900F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000EBEBEB00E4E4E400DDDDDD00D8D8
      D800D7D7D700DADADA00E1E1E100E9E9E900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000E5EEF10079D6F50036C6F70003B9
      F70003B8F60036C2F40079D2F100E5EDF000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EEEEEE0068956B00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EEEEEE0068956B00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000ECECEC00DEDEDE00DEDEDE00EDED
      ED005C9361004B854F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F0005C9361004B854F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E6E6E600BFBFBF00A3A3A300A0A0A000AAAAAA00A6A6A6005187
      5500559C5D005298590029702E00256A2A002265260053845500BBCBBC00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DCB08E00D49C7300D1956700CE916200CB8D5D00C9895A00C78655006593
      5A00559C5D005298590029702E00256A2A00226526004A703800BBCBBC00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000C28D6700BF8A6500BD876300BA846000B8825E00B37D5B00B17B
      5900B07A5700AD785600AC755500AA745300A8725200A8705000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000C28D6700BF8A6500BD876300BA846000B8825E00B37D5B00B17B
      5900B07A5700AD785600AC755500AA745300A8725200A8705000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DBDBDB00A7A7A700CECECE00EDEDED00F4F4F400F5F5F500509958005FA6
      67008CCD960089CB930086CA900083C98D0080C88B005FA66700497E4C00BBCB
      BC00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D7A07400F8F2ED00F7F0EA00F6EDE600F4EAE200F3E7DE00519957005FA6
      67008CCD960089CB930086CA900083C98D0080C88B005FA66700497E4C00BBCB
      BC00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C8916B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8715000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C8916B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8715000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000AEAEAE00DEDEDE00F3F3F300DBDBDB00D2D2D200DBDBDB00D6D6D600639F
      690061A869005CA36400347F3A00307935005096570081C88C005AA06200739B
      7600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D9A37900F9F3EE00EBD2BD00FFFFFF00EBD3BE00FFFFFF00FFFFFF0074B0
      7A0061A869005CA36400347F3A00307935005096570081C88C005AA06200739B
      7600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CA936D00FFFFFF00FFFFFF00FFFFFE00FFFFFD00FEFEFD00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFA00FEFEFA00FCFCF900FFFFFF00A9725200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CA936D00FFFFFF00B5B5B500B5B5B500FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FEFEFC00FEFEFC00FEFEFA00FEFEFA00FCFCF900FFFFFF00A9725200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B1B1B100F0F0F000DEDEDE00D4D4D400D2D2D200DBDBDB00D1D4D200BDBE
      BD005E9A630053945900DEDEDE00979797005F9663002C743200286E2D003D79
      4100F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DDA77D00F9F3EF00EBD0B900EBD0BA00EBD0BA00F4E6DA00F4EFE700F9F1
      EC006FAA71005F9E6100F4E6D900F4E6D900609662002C743200286E2D003D79
      4100F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CC966E00FFFFFF00FFFFFC00FFFFFD00FEFEFC00FEFEFC00FEFEFB00FDFD
      FA00FDFDFA00FDFDFA00FDFDFA00FCFCF700FBFBF600FFFFFF00AB745300F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CC966E00FFFFFF00B5B5B500B5B5B500B5B5B500FFFFFF00DCA67A00FFFF
      FF00FDFDFA00FDFDFA00FDFDFA00FCFCF700FBFBF600FFFFFF00AB745300F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B3B3B300F2F2F200E2E2E200D8D8D800D5D5D500DCDCDC00D8D8D800BFBF
      BF00B2B2B2006AA06F00E0E0E0009C9C9C00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DFA98100F9F3EF00EACEB600FFFFFF00EBD0BA00FFFFFF00FFFFFF00FFFF
      FF00F9F2EC0081B78500FFFFFF00FFFFFF00F7F0EB00C88C5E00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D19B7200FFFFFF00FEFEFC00FEFEFC00FEFEFC00FDFDFB00FDFDFB00FDFD
      FA00FDFDF800FBFBF900FBFAF700FBFAF600FBF8F400FFFFFF00AF795700F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D19B7200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FDFDF800FBFBF900FBFAF700FBFAF600FBF8F400FFFFFF00AF795700F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B4B4B400F3F3F300E7E7E700DDDDDD00D9D9D900E0E0E000DBDBDB00C3C3
      C300B6B7B600BABABA00E1E1E10060976600EEEFEE00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E1AD8600FAF4F000EACBB100EACCB200EACCB200F6E9DE00F9F1EA00F9F2
      EB00F3E5D900F5E6DB00F3E3D7007BAB7700F5EFE900C3855300F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D49D7400FFFFFF00FEFEFC00FDFDFB00FDFDFC00FDFDFB00FDFDF900FCFC
      F800FBF9F700FBF9F500FBF8F400FBF7F200FBF5F200FFFFFF00B17B5900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D49D7400DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00FFFF
      FF00FBF9F700FBF9F500FBF8F400FBF7F200FBF5F200FFFFFF00B17B5900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B6B6B600F4F4F400EAEAEA00E1E1E100DDDDDD0070C179005CB7670059B2
      63006EB07400BEBEBE00E2E2E200579B5E006CA97200EFEFEF00EAECEA00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E3B08B00FAF6F100EAC9AD00FFFFFF00EAC9AF0073C47D005CB7670059B2
      63007BBA7C00FFFFFF00FFFFFF0067AB6E006DA97100C4855400EAECEA00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D59F7500FFFFFF00FDFDFC00FDFDFB00FDFDFA00FCFCF900FCFBF700FBF9
      F500FBF8F400FBF7F300FBF5F200FAF3EF00F8F2EC00FFFFFF00B47D5B00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D59F7500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FBF8F400FBF7F300FBF5F200FAF3EF00F8F2EC00FFFFFF00B47D5B00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B8B8B800F5F5F500EEEEEE00E6E6E600E2E2E20098D09E008DCF9600A9D9
      B00079C2820056AE600051A85B006EB677006AB2730072AD7700F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E5B38E00FAF6F200E9C5A900E9C5AB00EAC7AB009DCF97008DCF9600A9D9
      B00079C2820056AE600051A85B006EB677006AB2730067914E00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D8A17800FFFFFF00FDFDFA00FCFCFA00FCFBF900FBFAF600FBF8F500FBF7
      F400FBF6F100F8F4EE00F7F2EB00F7F0EA00F6ECE800FFFFFF00B6805D00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D8A17800FFFFFF00B5B5B500FFFFFF00FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FBF6F100F8F4EE00F7F2EB00F7F0EA00F6ECE800FFFFFF00B6805D00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000B9B9B900F6F6F600E2E2E200CDCDCD00C3C3C300B2CAB50078C3820093D2
      9B00AADAB100A7D9AE00A4D8AC00A1D6A9009ED5A6006BB373005CA26300F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E7B69300FBF7F400E9C2A500FFFFFF00E8C3A800D9F1DC0083CF8C0093D2
      9B00AADAB100A7D9AE00A4D8AC00A1D6A9009ED5A6006BB373005CA26300F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D9A27800FFFFFF00FCFBF900FCFBF800FBF9F700FBF7F400FAF7F200F9F5
      F000F7F3ED00F6EFEA00F5EBE700F3EAE400F2E7DE00FFFFFF00B9845F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D9A27800FFFFFF00B5B5B500B5B5B500B5B5B500FFFFFF00DCA67A00FFFF
      FF00F7F3ED00F6EFEA00F5EBE700F3EAE400F2E7DE00FFFFFF00B9845F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000BBBBBB00F7F7F700D0D0D000DCDCDC00E8E8E800F9F9F900D4ECD70085CD
      8E0062BF6E005FBB6A005CB6660078C1810074BD7D007BBA8200F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E9B99700FBF7F400E9C2A500E9C2A500E9C2A500EFD3BC00D3E0C2008ACF
      8F0062BF6E005FBB6A005CB6660078C1810074BD7D0072A05B00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DBA37900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC866200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DBA37900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCA67A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC866200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000BDBDBD00F8F8F800FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FBFBFB00EAEAEA006AB573007EC18600F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EBBC9A00FBF7F400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0079C4820081C48800D1966900F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA6
      7A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00BF8A6500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA6
      7A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00BF8A6500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C7C7C700E1E1E100FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FBFBFB00CFCFCF0081BF8800EEEFEE00F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000ECBE9D00FBF7F4009BD5A40097D3A00093D09C008FCE97008ACB920086C9
      8D00A2D5A700B8DFBB00CDE8CF007EC98600F9F6F200D49A6E00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DDAC8500E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100E8B8
      9100E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100C0906F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DDAC8500E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100E8B8
      9100E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100C0906F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000E7E7E700C4C4C400D0D0D000E8E8E800F3F3F300FDFDFD00FCFCFC00EDED
      ED00E0E0E000C1C1C100BCBCBC00E9E9E900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EEC4A600FBF7F400FBF7F400FBF7F400FBF7F400FBF7F400FBF7F400FBF7
      F400FBF7F400FBF7F400FBF7F400FBF7F400FBF7F400D8A17600F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D2BAAD00DEB39000DCA67A00DCA57900DAA37900D8A17800D59F7500D49D
      7400D29C7200CF997100CE986F00CB956E00C9936B00C59D7E00D2BAAD00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DBC2B500DEB39100DCA67A00DCA57900DAA37900D8A17800D59F7500D49D
      7400D29C7200CF997100CE986F00CB956E00C9936B00C79D7F00DBC2B500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EFEFEF00DEDEDE00CACACA00C0C0C000B7B7B700B6B6B600BFBF
      BF00C7C7C700DEDEDE00EFEFEF00F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0D9C900EFC5AA00EDBF9E00EBBD9C00EBBB9900E9B99500E7B69200E6B4
      8F00E4B18B00E2AE8700E0AB8300DDA87F00DCA47C00DFB29200F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000BEA28D00B2907500AB856700A47A59009D704C00B1673600C283
      5700D38A6700E18E6F00DC8C6B00DA8A6C00D7896D00CD8A6B00AA6C4300A55E
      2D00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F0007DA98D0023713F00186A360023713F007DA98D00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CAB4A300B78F6C00D6B9A200DFC5B200E7D4C200EEDFD300C5825400EFCE
      B900DDFFFF0086EEC700A1F4D700A1F6D7008BEEC700E0FFFF00DDA18400AA69
      3D00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000E1E1E100C6C6C600ADADAD009C9C
      9C0099999900A8A8A800BFBFBF00DDDDDD00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000E1E1E100C5C5C500ACACAC009B9B
      9B0098989800A7A7A700BEBEBE00DDDDDD00F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F00080AB9000278B520063B98C0094D2B10063B98C00278B520079A6
      8A00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C1A48C00C7A38400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C27E5000EFB5
      9900EAF3E80050BE83006EC9970070C9980053BE8300E4F4E900DD9B7A00A968
      3900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000D6D6D600B6B6B600CECECE00E6E6E600F5F5
      F500F2F2F200DDDDDD00C0C0C000A2A2A200C9C9C900F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000D5D5D500B5B5B500CECECE00E6E6E600F5F5
      F500F2F2F200DDDDDD00BFBFBF00A1A1A100C9C9C900F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C09B8600C28D6700BF8A6500BD876300BA846000B8825E00B37D5B00B17B
      5900B07A57001F6B390061B98A005FB98600FFFFFF005FB8860066BB8E001F6E
      3C00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D4C2B100A06D3E00B3845800D9A47A00D89D6E00D79A6900C3805300EAB5
      9600F3F3EA00EDF1E600EFF1E600EFF0E600EDF1E500F3F5ED00D59B7800AF6F
      4300F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DBDBDB00BCBCBC00ECECEC00FEFEFE00F3F3F300E8E8
      E800E7E7E700F1F1F100FBFBFB00E1E1E1009E9E9E00CACACA00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DBDBDB00BBBBBB00ECECEC00FEFEFE00F3F3F300E8E8
      E800E7E7E700F1F1F100FBFBFB00E1E1E1009D9D9D00CACACA00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000C8916B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00307A4B009BD4B500FFFFFF00FFFFFF00FFFFFF0094D2B100186A
      3600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000EAE6E200BC997700D5AD8B00FDF0E500F7C7A100F7CFAC00C98A6000E6B4
      9100E2A68000E1A68000DEA27C00DCA07A00DB9E7800D99D7600D4997200BA7D
      5600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E8E8E800CBCBCB00F0F0F000FFFFFF00E5E5E500E5E5E500E4E4
      E400E3E3E300E2E2E200E1E1E100FEFEFE00E2E2E200A7A7A700DEDEDE00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E8E8E800CACACA00F0F0F000FFFFFF00E5E5E500E5E5E500EFEF
      EF00E3E3E300E2E2E200E1E1E100FEFEFE00E2E2E200A6A6A600DEDEDE00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CA936D00FFFFFF00FFFFFF00FFFFFE00FFFFFD00FEFEFD00FEFEFC00FEFE
      FC00FEFEFC00498A61008FD3B00091D6B000FFFFFF0064BB8B0066BB8E001F6E
      3C00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E5DDD400B6855500FEFEFD00FADEC100FADCBE00CA8C6400EAB7
      9800DDA47D00DDA57F00DBA27B00D99F7900D99F7800D89E7700D89D7700BE83
      5C00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DFDFDF00E4E4E400FEFEFE00E8E8E800E7E7E700E6E6E600E5E5
      E500E5E5E500E4E4E400E3E3E300E2E2E200FBFBFB00C6C6C600C4C4C400F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DFDFDF00E4E4E400FEFEFE00E8E8E800E7E7E700E6E6E6007272
      7200EFEFEF00E4E4E400E3E3E300E2E2E200FBFBFB00C5C5C500C4C4C400F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000CC966E00FFFFFF00FFFFFC00FFFFFD00FEFEFC00FEFEFC00FEFEFB00FDFD
      FA00FDFDFA00A6C5B00060AA800094D4B300B9E6D00069BA8E002C8E560079A6
      8A00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E8E2DC00B8855100FEFCF900F9DCBE00F8DBBE00C8875C00EFBE
      A000FDFCFA00FEFCFB00FEFDFD00FEFDFC00FDFBFA00FDFCFB00DDA78400C07E
      5200F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D9D9D900F2F2F200F5F5F500E9E9E900E9E9E900838383008282
      82008282820081818100E5E5E500E4E4E400F2F2F200E1E1E100B2B2B200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D9D9D900F2F2F200F5F5F500E9E9E900E9E9E900E8E8E8007777
      770073727200EFEFEF00E5E5E500E4E4E400F2F2F200E1E1E100B1B1B100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D19B7200FFFFFF00FEFEFC00FEFEFC00FEFEFC00FDFDFB00FDFDFB00FDFD
      FA00FDFDF800FBFBF900ABC8B4005F9874004E8D65004989600070785000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EEECEA00B8844A00FEFBF700F9DCC000F8DCBE00C7855A00EFBF
      9D00FFFFFF00CC926D00FFFFFF00FFFFFF00FFFBF700FFF8F100E4AE8B00C789
      6000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D5D5D500FCFCFC00EFEFEF00EBEBEB00EAEAEA006E6E6E006E6E
      6E006D6D6D0082828200E5E5E500E5E5E500E8E8E800F4F4F400A8A8A800F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D5D5D500FCFCFC00EFEFEF00EBEBEB00EAEAEA00E9E9E9007474
      74007877770073727200EFEFEF00E5E5E500E8E8E800F4F4F400A7A7A700F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D49D7400FFFFFF00FEFEFC00FDFDFB00FDFDFC00FDFDFB00FDFDF900FCFC
      F800FBF9F700FBF9F500FBF8F400FBF7F200FBF5F200FFFFFF00B17B5900F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000BD894E00FCF6F000F9DFC700F9DCBC00CC8C6400F3CD
      AF00FFFFFF00E3C7B200FFFFFF00FFFFFF00FFFFFF00FFFFFF00EABEA000C988
      5F00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D6D6D600FCFCFC00F0F0F000EDEDED00EBEBEB006E6E6E006E6E
      6E006E6E6E0083838300E7E7E700E6E6E600E9E9E900FAFAFA00ACACAC00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000D6D6D600FCFCFC00F0F0F000EDEDED00EBEBEB00EAEAEA007474
      74007474740079787800CDCDCD00E6E6E600E9E9E900FAFAFA00ABABAB00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D59F7500FFFFFF00FDFDFC00FDFDFB00FDFDFA00FCFCF900FCFBF700FBF9
      F500FBF8F400FBF7F300FBF5F200FAF3EF00F8F2EC00FFFFFF00B47D5B00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000CA9B6500F5E7D800FAE5D200F9DABB00D4966D00D49D
      7A00D0977000D6A38100CD8D6700CD8F6800D0997400D1987200C88A6100E2D0
      C400F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DCDCDC00F5F5F500F7F7F700EDEDED00EDEDED006F6F6F006F6F
      6F006E6E6E0083838300E9E9E900E8E8E800F4F4F400EEEEEE00BCBCBC00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000DCDCDC00F5F5F500F7F7F700EDEDED00EDEDED00ECECEC007574
      740075747400BFBFBF00E9E9E900E8E8E800F4F4F400EEEEEE00BBBBBB00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D8A17800FFFFFF00FDFDFA00FCFCFA00FCFBF900FBFAF600FBF8F500FBF7
      F400FBF6F100F8F4EE00F7F2EB00F7F0EA00F6ECE800FFFFFF00B6805D00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000D4AC7B00F0D9C000FBEDE100F9DABF00F9DCC100F9DE
      C400FAE0C700FAE2CA00FAE2CD00FAE5D000FFFEFD00CB8E5900CC985A00E6D7
      C500F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E3E3E300EBEBEB00FFFFFF00EFEFEF00EEEEEE00EDEDED00EDED
      ED00ECECEC00EBEBEB00E9E9E900E9E9E900FFFFFF00DDDDDD00D1D1D100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000E3E3E300EBEBEB00FFFFFF00EFEFEF00EEEEEE00EDEDED007675
      7500C1C1C100EBEBEB00E9E9E900E9E9E900FFFFFF00DDDDDD00D1D1D100F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D9A27800FFFFFF00FCFBF900FCFBF800FBF9F700FBF7F400FAF7F200F9F5
      F000F7F3ED00F6EFEA00F5EBE700F3EAE400F2E7DE00FFFFFF00B9845F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DBB88C00EDD0B100FFF6F000FAE1CA00FBE3CC00FBE3
      D000FBE6D300FBE9D500FCE9D800FCEADB00FFFFFD00D29C7000EED9C000D3A2
      6400F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EBEBEB00DCDCDC00F8F8F800FFFFFF00EFEFEF00EEEEEE00EDED
      ED00EDEDED00ECECEC00EBEBEB00FFFFFF00F5F5F500C8C8C800E6E6E600F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000EBEBEB00DCDCDC00F8F8F800FFFFFF00EFEFEF00EEEEEE00C2C2
      C200EDEDED00ECECEC00EBEBEB00FFFFFF00F5F5F500C7C7C700E6E6E600F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DBA37900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC866200F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E1C19800EBCAA400FFFDFB00FDE9D500FDEBD800FDEA
      DB00FDEDDF00FDF0E200FDF1E400FCF0E400FFFFFF00E09F6F00FFFBF900DFB7
      8600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E7E7E700D9D9D900F8F8F800FFFFFF00F8F8F800F2F2
      F200F1F1F100F7F7F700FFFFFF00F5F5F500CBCBCB00DFDFDF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E7E7E700D9D9D900F8F8F800FFFFFF00F8F8F800F2F2
      F200F1F1F100F7F7F700FFFFFF00F5F5F500CBCBCB00DFDFDF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA6
      7A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00DCA67A00BF8A6500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E5C8A200EBC59900FFFFFF00FCEFE200FDF0E700FDF1
      EB00FDF5EE00FDF8F100FDFAF700FFFCFA00FFFFFF00FEFBF700F4DABF00DCA9
      6600F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000E7E7E700DCDCDC00EBEBEB00F5F5F500FCFC
      FC00FCFCFC00F4F4F400E8E8E800D4D4D400E1E1E100F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000E7E7E700DCDCDC00EBEBEB00F5F5F500FCFC
      FC00FCFCFC00F4F4F400E8E8E800D4D4D400E1E1E100F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000DDAC8500E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100E8B8
      9100E8B89100E8B89100E8B89100E8B89100E8B89100E8B89100C0906F00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000E8D1B100EABF8B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDF9F400FBF3EA00F8EBD900F8E6D300F5DFC500E9CBA500DFAC6600E9D5
      BA00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000EBEBEB00E4E4E400DDDDDD00D8D8
      D800D7D7D700DADADA00E1E1E100E9E9E900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000EBEBEB00E4E4E400DDDDDD00D8D8
      D800D7D7D700DADADA00E1E1E100E9E9E900F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000D2BAAD00DEB39000DCA67A00DCA57900DAA37900D8A17800D59F7500D49D
      7400D29C7200CF997100CE986F00CB956E00C9936B00C59D7E00D2BAAD00F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000EDE1D100E5BA7F00EABB8000E8B67600E6B16C00E4AF
      6700E3AF6700E4B36E00E5B87900E5B97B00E6BD8500E7C39000ECDCC500F0EF
      ED00F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000424D3E000000000000003E000000
      2800000060000000480000000100010000000000600300000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FF81FFFF00FFFF00FF000000FE007FFE007FFE00
      7F000000FC003FFC003FFC003F000000FC003FF9001FF8001F000000F8001FF8
      001FF8001F000000F8001FF8001FF8001F000000F8001FF8001FF8001F000000
      F8001FF9001FF8001F000000F8001FF8011FF8001F000000F8001FF8001FF800
      1F000000FC003FF8001FF8001F000000FC003FFC003FFC003F000000FE007FFE
      007FFE007F000000FF81FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF3FFFFF3FFFFFFFFFFFFFFFF03FFFFF3FFFFFFFFFFFFFFF8001FF0001FF800
      3FF8003FF0000FF0000FF0001FF0001FF0000FF0000FF0001FF0001FF4000FF0
      000FF0001FF0001FF000FFF0003FF0001FF0001FF0007FF0003FF0001FF0001F
      F0001FF0001FF0001FF0001FF0003FF0003FF0001FF0001FF0001FF0001FF000
      1FF0001FF0003FF0003FF0001FF0001FF0007FF0003FF0001FF0001FF0007FF0
      003FF0001FF0001FF000FFF0003FF0001FF0001FF801FFF0003FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFF8000FFFFFFFFFFFFFFFFC1FF0000FFF00FFFF00FFFFF80FF0000FFE00
      7FFE007FF0000FF0000FFC003FFC003FF0000FF0000FF9001FF9001FF0000FF0
      000FF8001FF8001FF0000FF0000FF8001FF8001FF0001FF0000FF8001FF8001F
      F0001FF0000FF9001FF9001FF0001FF0000FF8001FF8001FF0001FF0000FF800
      1FF8001FF0001FF0000FF8001FF8001FF0001FF0000FFC003FFC003FF0001FF0
      000FFE007FFE007FF0001FF0000FFF00FFFF00FFF0001FF0000FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object fs: TFileSaveDialog
    DefaultExtension = '.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Text File (*.txt)'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'FQ (*.fq)'
        FileMask = '*.fq'
      end
      item
        DisplayName = 'Script File (*.script)'
        FileMask = '*.script'
      end>
    Options = []
    Title = 'Save File...'
    Left = 708
    Top = 29
  end
  object SynFQSyn1: TSynFQSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = 6990032
    KeyAttri.Foreground = 10770750
    NumberAttri.Foreground = 3420299
    StringAttri.Foreground = 3420299
    VariableAttri.Foreground = 10711363
    Left = 619
    Top = 29
  end
  object fo: TFileOpenDialog
    DefaultExtension = '.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Text File (*.txt)'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'FQ (*.fq)'
        FileMask = '*.fq'
      end
      item
        DisplayName = 'Script File (*.script)'
        FileMask = '*.script'
      end>
    Options = []
    Title = 'Open File...'
    Left = 668
    Top = 28
  end
  object MenuMain: TMainMenu
    Left = 968
    Top = 30
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = ClearCode1Click
      end
      object Open1: TMenuItem
        Caption = 'Open...'
        OnClick = Open1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Caption = 'Save'
        Enabled = False
        OnClick = ToolButton3Click
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
        Enabled = False
        OnClick = SaveAs1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object EncodeandSaveRAW1: TMenuItem
        Caption = 'Save &RAW Scrtip As...'
        Enabled = False
        OnClick = EncodeandSaveRAW1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = '&Edit'
    end
    object Script1: TMenuItem
      Caption = '&Script'
      object AutoDownload: TMenuItem
        Caption = 'Auto &Download'
        Enabled = False
        OnClick = MenuItemChangeCheck
      end
      object AutoReload: TMenuItem
        Caption = 'Auto &Load Last'
        Enabled = False
        OnClick = MenuItemChangeCheck
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object CheckReset: TMenuItem
        Caption = 'On Load &Reset Script'
        Enabled = False
        OnClick = MenuItemChangeCheck
      end
      object CheckRun: TMenuItem
        Caption = 'On Load Run &Main'
        Enabled = False
        OnClick = MenuItemChangeCheck
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object CrazyTestInterval1: TMenuItem
        Caption = '&Crazy Test Interval'
        Enabled = False
        OnClick = CrazyTestInterval1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object SetHTTPUrl1: TMenuItem
        Caption = 'Change Script &Url'
        Enabled = False
        OnClick = SetHTTPUrl1Click
      end
      object ClerHTTPFolder1: TMenuItem
        Caption = 'Clear &HTTP Folders'
        OnClick = ClerHTTPFolder1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object ClearScript1: TMenuItem
        Caption = '&Clear Script'
        OnClick = ClearScript1Click
      end
      object ReloadScriptfromHTTP1: TMenuItem
        Caption = 'Load Script from &HTTP (Reset)'
        Enabled = False
        ShortCut = 115
        OnClick = ReloadScriptfromHTTP1Click
      end
      object LoadScriptfromHTTPNoreset1: TMenuItem
        Caption = 'Load Script from HTTP (No reset)'
        Enabled = False
        ShortCut = 114
        OnClick = LoadScriptfromHTTPNoreset1Click
      end
    end
    object Console1: TMenuItem
      Caption = '&Console'
      object CheckAutoscroll: TMenuItem
        Caption = '&Auto Scroll'
        Checked = True
        OnClick = MenuItemChangeCheck
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object RunMode1: TMenuItem
        Caption = '&Debug Attach'
        object CheckOnLog: TMenuItem
          Caption = '&Log Event'
          Checked = True
          GroupIndex = 2
          OnClick = MenuItemChangeCheck
        end
        object CheckOnStack: TMenuItem
          Caption = '&Stack Event'
          Checked = True
          GroupIndex = 2
          OnClick = MenuItemChangeCheck
        end
        object CheckOnVar: TMenuItem
          Caption = '&Var set Event'
          Checked = True
          GroupIndex = 2
          OnClick = MenuItemChangeCheck
        end
      end
      object LogLevel1: TMenuItem
        Caption = 'Log &Level'
        object CheckLogLevel7: TMenuItem
          Caption = '&Script Output'
          Checked = True
          OnClick = MenuItemChangeCheck
        end
        object N1: TMenuItem
          Caption = '-'
        end
        object CheckLogLevel0: TMenuItem
          Caption = '0: System &Status'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel1: TMenuItem
          Caption = '1: &Errors'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel2: TMenuItem
          Caption = '2: &Warnings'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel3: TMenuItem
          Caption = '3: &Informational'
          Checked = True
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel4: TMenuItem
          Caption = '4: &Verbose'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel5: TMenuItem
          Caption = '5: E&xtra verbose'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
        object CheckLogLevel6: TMenuItem
          Caption = '6: Stupi&d verbose'
          GroupIndex = 1
          RadioItem = True
          OnClick = MenuItemChangeCheck
        end
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object ClearAllLog1: TMenuItem
        Caption = 'Clear &All'
        OnClick = ClearAllLog1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object ClearBuffer1: TMenuItem
        Caption = '&Clear Buffer'
        OnClick = ClearBuffer1Click
      end
      object ClearStackLog1: TMenuItem
        Caption = 'Clear &Stack Log'
        OnClick = ClearStackLog1Click
      end
      object ClearVarLog1: TMenuItem
        Caption = 'Clear &Var Log'
        OnClick = ClearVarLog1Click
      end
      object ClearCode1: TMenuItem
        Caption = 'Clear User &Code'
        OnClick = ClearCode1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object ClearParams1: TMenuItem
        Caption = 'Clear Run &Params'
        OnClick = ClearParams1Click
      end
      object ClearScriptParams1: TMenuItem
        Caption = 'Clear &Script Params'
        OnClick = ClearScriptParams1Click
      end
    end
    object Window1: TMenuItem
      Caption = '&Window'
      object CheckLeaks: TMenuItem
        Caption = 'Report &Memory Leaks'
        Enabled = False
        OnClick = MenuItemChangeCheck
      end
    end
  end
  object CrazyTest: TTimer
    Enabled = False
    Interval = 7000
    OnTimer = CrazyTestTimer
    Left = 564
    Top = 28
  end
end
