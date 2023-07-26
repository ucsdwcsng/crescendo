function v = read_float_binary(filename, count, start)
%READ_FLOAT_BINARY Summary of this function goes here
%   Detailed explanation goes here

m = nargchk (1,3,nargin);
if (m)
    usage (m);
end

if (nargin < 2)
    count = Inf;
end

if (nargin <3)
    start=0;
end

f = fopen (filename, 'rb');
if (f < 0)
    v = 0;
else
    s = fseek(f,4*1*start,-1);
    v = fread (f, [1, count], 'float');
    fclose (f);
    [r, c] = size (v);
    v = reshape (v, c, r);
end

end