PATH='resourse/woman.tiff';
I = imread(PATH);
I_mixed = [I(:,:,1);I(:,:,2);I(:,:,3)];
J = histeq(I);
%ouput:
subplot(1,2,1);imshow(I);title('ORIGIN');
subplot(1,2,2);imshow(J);title('HE');
