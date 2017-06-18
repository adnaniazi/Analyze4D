function flag = isThereInternet()
% This function returns a 1 if basic internet connectivity
% is present and returns a zero if no internet connectivity
% is detected.

% Check google if its accesible
url =java.net.URL('http://google.com');

% read the URL
link = openStream(url);
parse = java.io.InputStreamReader(link);
snip = java.io.BufferedReader(parse);
if ~isempty(snip)
    flag = 1;
else
    flag = 0
end
return