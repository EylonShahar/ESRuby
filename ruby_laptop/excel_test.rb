require 'win32ole'

# -4100 is the value for the Excel constant xl3DColumn.
ChartTypeVal = -4100;

# Creates OLE object to Excel
excel = WIN32OLE.new("excel.application")

# Create and rotate the chart

#excel['Visible'] = TRUE;
workbook = excel.Workbooks.Add();
excel.Range("a1")['Value'] = 3;
excel.Range("a2")['Value'] = 2;
excel.Range("a3")['Value'] = 1;
excel.Range("a1:a3").Select();
excelchart = workbook.Charts.Add();
excelchart['Type'] = ChartTypeVal;

30.step(180, 10) do |rot|
    excelchart['Rotation'] = rot
end

excelchart2 = workbook.Charts.Add();
excelchart3 = workbook.Charts.Add();

charts = workbook.Charts
charts.each { |i| puts i }

excel.ActiveWorkbook.Close(0);
excel.Quit();
