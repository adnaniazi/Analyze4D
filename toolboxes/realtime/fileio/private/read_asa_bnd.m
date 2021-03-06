function bnd = read_asa_bnd(fn);

% READ_ASA_BND reads an ASA boundary triangulation file
% converting the units of the vertices to mm

% Copyright (C) 2002, Robert Oostenveld
%
% This file is part of FieldTrip, see http://www.ru.nl/neuroimaging/fieldtrip
% for the documentation and details.
%
%    FieldTrip is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    FieldTrip is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with FieldTrip. If not, see <http://www.gnu.org/licenses/>.
%
% $Id: read_asa_bnd.m 2209 2010-11-27 10:25:04Z roboos $

Npnt = read_asa(fn, 'NumberPositions=', '%d');
Ndhk = read_asa(fn, 'NumberPolygons=', '%d');
Unit = read_asa(fn, 'UnitPosition', '%s');

pnt = read_asa(fn, 'Positions', '%f');
if any(size(pnt)~=[Npnt,3])
  pnt_file = read_asa(fn, 'Positions', '%s');
  [path, name, ext] = fileparts(fn);
  fid = fopen(fullfile(path, pnt_file), 'rb', 'ieee-le');
  pnt = fread(fid, [3,Npnt], 'float')';
  fclose(fid);
end

dhk = read_asa(fn, 'Polygons', '%f');
if any(size(dhk)~=[Ndhk,3])
  dhk_file = read_asa(fn, 'Polygons', '%s');
  [path, name, ext] = fileparts(fn);
  fid = fopen(fullfile(path, dhk_file), 'rb', 'ieee-le');
  dhk = fread(fid, [3,Ndhk], 'int32')';
  fclose(fid);
end

if strcmpi(Unit,'mm')
  pnt   = 1*pnt;
elseif strcmpi(Unit,'cm')
  pnt   = 100*pnt;
elseif strcmpi(Unit,'m')
  pnt   = 1000*pnt;
else
  error(sprintf('Unknown unit of distance for triangulated boundary (%s)', Unit));
end

bnd.pnt = pnt;
bnd.tri = dhk + 1;      % 1-offset instead of 0-offset
% bnd.tri = fliplr(bnd.tri);    % invert order of triangle vertices

