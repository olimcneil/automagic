function downloadCRD()
% downloadCRD  Download the cleanrawdata() package
%   It asks the user whether they want to download the package or not. If
%   not, the preprocessing is stopped. Otherwise, in a first attepmt, the
%   folder matlab_scripts in the parent directory is selected to download
%   the package into it. If the folder does not exist, the user is asked to
%   select a folder in which the package will be downloaded.
%
% Copyright (C) 2017  Amirreza Bahreini, amirreza.bahreini@uzh.ch
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>


% System dependence:
if(ispc)
    slash = '\';
else
    slash = '/';
end

CSTS = PreprocessingConstants;
URL = CSTS.CRDCsts.URL;

% Ask user if they want to download the package now
ques = ['clean_artifacts.m is necessary for cleanrawdata() '...
    'Do you want to download it now?'];
ques_title = 'cleanrawdata() Requirement installation';
if(exist('questdlg2', 'file'))
    res = questdlg2( ques , ques_title, 'No', 'Yes', 'Yes' );
else
    res = questdlg( ques , ques_title, 'No', 'Yes', 'Yes' );
end

if(strcmp(res, 'No'))
   msg = 'Preprocessing failed as cleanrawdata() package is not yet installed.';
    if(exist('warndlg2', 'file'))
        warndlg2(msg);
    else
        warndlg(msg);
    end
    return; 
end


folder = ['.' slash 'matlab_scripts' slash];

% Download the package
zip_name = [folder 'asr.zip'];  
outfilename = websave(zip_name, URL);
unzip(outfilename,strcat(folder, 'crd/'));
addpath(genpath(strcat(folder, 'crd/')));
delete(zip_name);
fprintf(['cleanrawdata() package successfully installed.'...
    ' Continuing preprocessing....']);
    
end