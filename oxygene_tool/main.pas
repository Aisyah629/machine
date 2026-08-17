program OxygeneTool;

uses
  System.Threading, System.IO, System.Linq, System.Net.Http;

type
  DataService = class
  private
    data: ConcurrentDictionary<string, string>;
    lock: Object;
  public
    constructor Create;
    procedure ProcessAsync(request: HttpRequestMessage);
    function GetDataAsync(key: string): Task<string>;
  end;

implementation

constructor DataService.Create;
begin
  data := new ConcurrentDictionary<string, string>();
  lock := new Object();
end;

procedure DataService.ProcessAsync(request: HttpRequestMessage);
begin
  Task.Run(procedure
  var
    key: string := request.RequestUri.ToString().Split('/').LastOrDefault() ?? 'default';
    value: string := 'Processed at ' + DateTime.Now.ToString();
  begin
    lock.Enter();
    try
      data.TryAdd(key, value);
    finally
      lock.Exit();
    end;
  end);
end;

function DataService.GetDataAsync(key: string): Task<string>;
begin
  Result := Task.Run(function: string
  begin
    lock.Enter();
    try
      if data.TryGetValue(key, Result) then
        Result := Result ?? 'No data found for key: ' + key
      else
        Result := 'No data found for key: ' + key;
    finally
      lock.Exit();
    end;
    exit Result;
  end);
end;

var
  service: DataService;
begin
  service := new DataService();
  service.ProcessAsync(new HttpRequestMessage());
  WriteLn('Oxygene Tool Initialized. Ready for enterprise web service tasks.');
  ReadLn();
end.
