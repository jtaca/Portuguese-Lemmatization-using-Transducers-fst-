#!/bin/bash
################### Lemmas ################
#
mkdir FINALpdf
mkdir FINALtransducers

# Compila e gera a versão gráfica do lemma2noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2noun.txt | fstarcsort > FINALtransducers/lemma2noun.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2noun.fst | dot -Tpdf  > FINALpdf/lemma2noun.pdf

# Compila e gera a versão gráfica do lemma2adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2adverb.txt | fstarcsort > FINALtransducers/lemma2adverb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2adverb.fst | dot -Tpdf  > FINALpdf/lemma2adverb.pdf

# Compila e gera a versão gráfica do lemma2verbip
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbip.txt | fstarcsort > FINALtransducers/lemma2verbip.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbip.fst | dot -Tpdf  > FINALpdf/lemma2verbip.pdf
# Compila e gera a versão gráfica do lemma2verbis
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbis.txt | fstarcsort > FINALtransducers/lemma2verbis.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbis.fst | dot -Tpdf  > FINALpdf/lemma2verbis.pdf
# Compila e gera a versão gráfica do lemma2verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > FINALtransducers/lemma2verbif.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verbif.fst | dot -Tpdf  > FINALpdf/lemma2verbif.pdf

# Gera a versão gráfica do lemma2verb
fstunion FINALtransducers/lemma2verbip.fst FINALtransducers/lemma2verbis.fst > FINALtransducers/lemma2verbAUX.fst
fstunion FINALtransducers/lemma2verbAUX.fst FINALtransducers/lemma2verbif.fst > FINALtransducers/lemma2verb.fst
rm FINALtransducers/lemma2verbAUX.fst || echo 'removal failed'
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2verb.fst | dot -Tpdf  > FINALpdf/lemma2verb.pdf

# Gera a versão gráfica do lemma2word
fstunion FINALtransducers/lemma2verb.fst FINALtransducers/lemma2adverb.fst > FINALtransducers/lemma2wordAUX.fst
fstunion FINALtransducers/lemma2wordAUX.fst FINALtransducers/lemma2noun.fst > FINALtransducers/lemma2word.fst
rm FINALtransducers/lemma2wordAUX.fst || echo 'removal failed'
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/lemma2word.fst | dot -Tpdf  > FINALpdf/lemma2word.pdf

##Gera a versão gráfica do word2lemma
fstinvert FINALtransducers/lemma2word.fst > FINALtransducers/word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait FINALtransducers/word2lemma.fst | dot -Tpdf  > FINALpdf/word2lemma.pdf

################### Testa os tradutores ################
mkdir FINALexamples

echo "Test Transdutor test1 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test1.txt | fstarcsort > test1.fst
fstrmepsilon test1.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test1.fst FINALtransducers/lemma2verb.fst  > test1_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test1_lemma2verb.fst | dot -Tpdf  > FINALexamples/test1_lemma2verb.pdf
#echo "lemma2word"
fstcompose test1.fst FINALtransducers/lemma2word.fst  > test1_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test1_lemma2word.fst | dot -Tpdf  > FINALexamples/test1_lemma2word.pdf
#echo "word2lemma"
fstcompose test1.fst FINALtransducers/word2lemma.fst  > test1_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test1_word2lemma.fst | dot -Tpdf  > FINALexamples/test1_word2lemma.pdf

echo "Test Transdutor test2 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test2.txt | fstarcsort > test2.fst
fstrmepsilon test2.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test2.fst FINALtransducers/lemma2verb.fst  > test2_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test2_lemma2verb.fst | dot -Tpdf  > FINALexamples/test2_lemma2verb.pdf
#echo "lemma2word"
fstcompose test2.fst FINALtransducers/lemma2word.fst  > test2_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test2_lemma2word.fst | dot -Tpdf  > FINALexamples/test2_lemma2word.pdf
#echo "word2lemma"
fstcompose test2.fst FINALtransducers/word2lemma.fst  > test2_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test2_word2lemma.fst | dot -Tpdf  > FINALexamples/test2_word2lemma.pdf

echo "Test Transdutor test3 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test3.txt | fstarcsort > test3.fst
fstrmepsilon test3.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test3.fst FINALtransducers/lemma2verb.fst  > test3_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test3_lemma2verb.fst | dot -Tpdf  > FINALexamples/test3_lemma2verb.pdf
#echo "lemma2word"
fstcompose test3.fst FINALtransducers/lemma2word.fst  > test3_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test3_lemma2word.fst | dot -Tpdf  > FINALexamples/test3_lemma2word.pdf
#echo "word2lemma"
fstcompose test3.fst FINALtransducers/word2lemma.fst  > test3_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test3_word2lemma.fst | dot -Tpdf  > FINALexamples/test3_word2lemma.pdf

echo "Test Transdutor test4 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test4.txt | fstarcsort > test4.fst
fstrmepsilon test4.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test4.fst FINALtransducers/lemma2verb.fst  > test4_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test4_lemma2verb.fst | dot -Tpdf  > FINALexamples/test4_lemma2verb.pdf
#echo "lemma2word"
fstcompose test4.fst FINALtransducers/lemma2word.fst  > test4_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test4_lemma2word.fst | dot -Tpdf  > FINALexamples/test4_lemma2word.pdf
#echo "word2lemma"
fstcompose test4.fst FINALtransducers/word2lemma.fst  > test4_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test4_word2lemma.fst | dot -Tpdf  > FINALexamples/test4_word2lemma.pdf

echo "Test Transdutor 5 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test5.txt | fstarcsort > test5.fst
fstrmepsilon test5.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test5.fst FINALtransducers/lemma2verb.fst  > test5_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test5_lemma2verb.fst | dot -Tpdf  > FINALexamples/test5_lemma2verb.pdf
#echo "lemma2word"
fstcompose test5.fst FINALtransducers/lemma2word.fst  > test5_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test5_lemma2word.fst | dot -Tpdf  > FINALexamples/test5_lemma2word.pdf
#echo "word2lemma"
fstcompose test5.fst FINALtransducers/word2lemma.fst  > test5_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test5_word2lemma.fst | dot -Tpdf  > FINALexamples/test5_word2lemma.pdf

echo "Test Transdutor test6 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test6.txt | fstarcsort > test6.fst
fstrmepsilon test6.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test6.fst FINALtransducers/lemma2verb.fst  > test6_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test6_lemma2verb.fst | dot -Tpdf  > FINALexamples/test6_lemma2verb.pdf
#echo "lemma2word"
fstcompose test6.fst FINALtransducers/lemma2word.fst  > test6_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test6_lemma2word.fst | dot -Tpdf  > FINALexamples/test6_lemma2word.pdf
#echo "word2lemma"
fstcompose test6.fst FINALtransducers/word2lemma.fst  > test6_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test6_word2lemma.fst | dot -Tpdf  > FINALexamples/test6_word2lemma.pdf

echo "Test Transdutor test7 :"
fstcompile --isymbols=syms.txt --osymbols=syms.txt  test7.txt | fstarcsort > test7.fst
fstrmepsilon test7.fst | fsttopsort | fstprint --isymbols=syms.txt
#echo "lemma2verb"
fstcompose test7.fst FINALtransducers/lemma2verb.fst  > test7_lemma2verb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7_lemma2verb.fst | dot -Tpdf  > FINALexamples/test7_lemma2verb.pdf
#echo "lemma2word"
fstcompose test7.fst FINALtransducers/lemma2word.fst  > test7_lemma2word.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7_lemma2word.fst | dot -Tpdf  > FINALexamples/test7_lemma2word.pdf
#echo "word2lemma"
fstcompose test7.fst FINALtransducers/word2lemma.fst  > test7_word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait test7_word2lemma.fst | dot -Tpdf  > FINALexamples/test7_word2lemma.pdf
