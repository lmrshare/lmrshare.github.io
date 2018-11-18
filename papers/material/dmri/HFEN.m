function hfen = HFEN(truth,y)
hfen=norm(imfilter(abs(y),fspecial('log',15,1.5)) - imfilter(truth,fspecial('log',15,1.5)),'fro');