function sys=quadripulse_controller14ref
sys = [];
sys.child = [];
sys.NumDataTypes = 7; 
sys.DataTypes = [];
temp.EnumNames='';
temp.EnumValues = [];
temp.Name = '';
sys.DataTypes = repmat(temp,1,7);
sys.DataTypes(1).Name = 'real_T';
sys.DataTypes(2).Name = 'uint8_T';
sys.DataTypes(3).Name = 'boolean_T';
sys.DataTypes(4).Name = 'int32_T';
sys.DataTypes(5).Name = 'creal_T';
sys.DataTypes(6).Name = 'uint32_T';
sys.DataTypes(7).Name = 'uint16_T';
