unit helper.strings;

interface

uses
  System.SysUtils;

type
  THelperStrings = class
  public
    class function IsSubParameter(name: string): boolean;
    class procedure SplitSubParameter(expression: string;
      out name, field: string);
  end;

implementation

{ THelperStrings }

class function THelperStrings.IsSubParameter(name: string): boolean;
begin
  result := Pos('.', name) <> 0;
end;

class procedure THelperStrings.SplitSubParameter(expression: string;
  out name, field: string);
var
  tokens: TArray<string>;

begin
  tokens := expression.Split(['.']);
  if Length(tokens) <> 0 then
  begin
    name := tokens[0];
    field := tokens[1];
  end
  else
  begin
    name := expression;
    field := '';
  end;
end;

end.
