function [r] = loadAMfile(filename, varargin)
if nargin ~= 1
    [Filename,Pathname] = uigetfile({'*.am';},'select AM file');
    if Filename == 0
        return
    end
    filename = strcat(Pathname, Filename);
else
%     filename = varargin{1};
end

fid = fopen(filename, 'r');
if fid == -1
    disp(['failed to open file ', filename]);
    return
end

filehead = fread(fid, 800, 'char=>char');
tmp = findstr(filehead', '@1');
dataoffset = tmp(1, 2) + 2

tmp2 = findstr(filehead', 'define Lattice ');
tmpstr = filehead(tmp2 + 15:end);
disp(tmpstr')
tmp3 = findstr(tmpstr', ' ');
tmp4 = findstr(tmpstr', 'P');
tmpstr1 = tmpstr(1:tmp3(1));
size1 = str2num(tmpstr1')
tmpstr2 = tmpstr(tmp3(1):tmp3(2));
size2 = str2num(tmpstr2')
tmpstr3 = tmpstr(tmp3(2):tmp4(1) - 3);
size3 = str2num(tmpstr3')
size3 = 100;

fseek(fid, dataoffset, 'bof');
r = fread(fid, size1*size2*size3, 'float');
r = reshape(r, size1, size2, size3);

fclose(fid);