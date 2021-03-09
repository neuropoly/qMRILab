function updateUnitLabel(handles,viewException)
% Update the unit label based on the value of the SourcePop dropdown menu. 
% When the CurrentData of the handles points to method x, but method y is
% selected from the dropdown, the SourcePop set to ' ' to inform this
% function.
% text101 is the UIComponent responsible for displaying the unit.
try
Method = GetMethod(handles);
reg = modelRegistry('get',Method);
if ~strcmp(get(handles.SourcePop,'String'),' ')
cur_sel = handles.SourcePop.String{get(handles.SourcePop,'Value')};
if ismember(cur_sel,fieldnames(reg.Mappings.Output))
    dispUnit = reg.Mappings.Output.(cur_sel);
else
    dispUnit = reg.Mappings.Input.(cur_sel);
end
 set(handles.text101,'String',sprintf([dispUnit.Label '\n' dispUnit.Symbol]));
else
 set(handles.text101,'String','');    
end

if ~isempty(handles.CurrentData) && isfield(handles.CurrentData,'Version') && ~viewException
    % Change this to 2.4.9 before release 2.5.0!!!
    if checkanteriorver(handles.CurrentData.Version, [2 4 0])
        set(handles.text101,'String',sprintf(['n/a \nv' num2str(handles.CurrentData.Version(1)) '.' num2str(handles.CurrentData.Version(2)) '.' num2str(handles.CurrentData.Version(3))])); 
    end 
end
catch
  set(handles.text101,'String','Not registered');    
end
