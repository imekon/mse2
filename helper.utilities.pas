unit helper.utilities;

interface

uses
  System.Classes;

procedure Split(Str: string; Delimiter: Char; list: TStrings);

implementation

procedure Split(Str: string; Delimiter: Char; list: TStrings);
begin
   list.Clear;
   list.Delimiter       := Delimiter;
   list.StrictDelimiter := True; // Requires D2006 or newer.
   list.DelimitedText   := Str;
end;

end.
