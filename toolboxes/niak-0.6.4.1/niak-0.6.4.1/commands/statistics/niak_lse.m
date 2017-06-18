function [beta,e] = niak_lse(y,x)
% Least-square estimates in a linear model Y = X*BETA + E 
%
% [BETA,E] = NIAK_LSE(Y,X)
%
% _________________________________________________________________________
% INPUTS:
%
% Y
%   (2D array size T*N) each column of Y are samples of one variable.
%
% X
%   (2D array size T*K) each column of X is a explaining factor with the 
%   same number of rows as Y.
%
% _________________________________________________________________________
% OUTPUTS:
% BETA
%   (vector size K*N) BETA(k,n) is the estimated coefficient regression 
%   estimate of X(:,k) on Y(:,n), using the least-square criterion.
%
% E
%   (2D array, size T*N) residuals of the regression
%
% _________________________________________________________________________
% COMMENTS
%
% Copyright (c) Pierre Bellec, Montreal Neurological Institute, 2008-2010.
% Maintainer : pierre.bellec@criugm.qc.ca
% See licensing information in the code.
% Keywords : Statistics, General Linear Model

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

beta = (x'*x)^(-1)*x'*y;
e = y-x*beta;