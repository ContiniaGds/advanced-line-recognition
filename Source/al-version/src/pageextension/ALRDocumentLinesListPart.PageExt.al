#pragma warning disable AA0072
pageextension 61001 "ALR Document Lines ListPart" extends "CDC Document Lines ListPart"
{
    ContextSensitiveHelpPage = 'document-lines';
    actions
    {
        addafter(Line)
        {
            group(AdvancedLineRecognition)
            {
                Caption = 'Adv. line recognition';
                Image = SetupLines;

                action(SearchByLinkedField)
                {
                    ApplicationArea = All;
                    Caption = 'Find value by linked field';
                    Description = 'Das ist eine Beschreibung';
                    Image = Link;
                    ToolTip = 'The desired field is found via a fixed offset (distance) from another field.';

                    trigger OnAction()
                    begin
                        AdvLineRecognitionMgt.SetToAnchorLinkedField(Rec);
                    end;
                }
                action(SearchByColumnHeading)
                {
                    ApplicationArea = All;
                    Caption = 'Find value by column heading';
                    Image = "Table";
                    ToolTip = 'The desired field is searched for using a previously trained column heading in the range of the current position.';

                    trigger OnAction()
                    begin
                        AdvLineRecognitionMgt.SetToFieldSearchWithColumnHeding(Rec);
                    end;
                }
                action(SearchByCaption)
                {
                    ApplicationArea = All;
                    Caption = 'Find value by caption';
                    Image = Find;
                    ToolTip = 'The desired field is searched for using a previously trained search text/caption in the area of the current position.';

                    trigger OnAction()
                    begin
                        AdvLineRecognitionMgt.SetToFieldSearchWithCaption(Rec);
                    end;
                }
                action(ResetFieldToDefault)
                {
                    ApplicationArea = All;
                    Caption = 'Reset field';
                    Image = ResetStatus;
                    ToolTip = 'The advanced line recognition settings are reset for the desired field.';

                    trigger OnAction()
                    begin
                        AdvLineRecognitionMgt.ResetFieldFromMenu(Rec);
                    end;
                }
                action(ShowVersionNo)
                {
                    ApplicationArea = All;
                    Caption = 'Version';
                    Image = Info;
                    ToolTip = 'Displays the currently used version of the advanced line detection.';
                    trigger OnAction()
                    begin
                        AdvLineRecognitionMgt.ShowVersionNo();
                    end;
                }
                action(DisableFieldRecognition)
                {
                    ApplicationArea = All;
                    Caption = 'Disable field detection';
                    Image = SelectField;
                    ToolTip = 'Disables the automatic field detection.';
                    Visible = ShowFieldRecognition;
                    trigger OnAction()
                    begin

                        ALRMgtSI.FlipAutoFieldRecognition();
                        ShowFieldRecognition := ALRMgtSI.GetAutoFieldRecognition();
                    end;
                }
                action(EnableFieldRecognition)
                {
                    ApplicationArea = All;
                    Caption = 'Enable field detection';
                    Image = SelectField;
                    ToolTip = 'Enable the automatic field detection. The system will use the last captured field during setting up advanced line recognition.';
                    Visible = not ShowFieldRecognition;
                    trigger OnAction()
                    begin
                        ALRMgtSI.FlipAutoFieldRecognition();
                        ShowFieldRecognition := ALRMgtSI.GetAutoFieldRecognition();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowFieldRecognition := ALRMgtSI.GetAutoFieldRecognition();
    end;


    var
        ALRMgtSI: Codeunit "ALR Single Instance Mgt.";
        AdvLineRecognitionMgt: Codeunit "ALR Adv. Recognition Mgt.";
        [InDataSet]
        ShowFieldRecognition: boolean;
}
#pragma warning restore