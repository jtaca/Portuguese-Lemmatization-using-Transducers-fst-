#!/bin/bash


################### letras ################
#
# Compila e gera a versão gráfica do lemma2noun
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2noun.txt | fstarcsort > lemma2noun.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2noun.fst | dot -Tpdf  > lemma2noun.pdf
# Compila e gera a versão gráfica do teste aluno
fstcompile --isymbols=syms.txt --osymbols=syms.txt  aluno.txt | fstarcsort > aluno.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait aluno.fst | dot -Tpdf  > aluno.pdf





# Compila e gera a versão gráfica do lemma2adverb
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2adverb.txt | fstarcsort > lemma2adverb.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2adverb.fst | dot -Tpdf  > lemma2adverb.pdf
# Compila e gera a versão gráfica do teste inteligentemente
fstcompile --isymbols=syms.txt --osymbols=syms.txt  inteligentemente.txt | fstarcsort > inteligentemente.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait inteligentemente.fst | dot -Tpdf  > inteligentemente.pdf


# Compila e gera a versão gráfica do lemma2verbip
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbip.txt | fstarcsort > lemma2verbip.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbip.fst | dot -Tpdf  > lemma2verbip.pdf
# Compila e gera a versão gráfica do teste lavar
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lavar.txt | fstarcsort > lavar.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lavar.fst | dot -Tpdf  > lavar.pdf


# Compila e gera a versão gráfica do lemma2verbis
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbis.txt | fstarcsort > lemma2verbis.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbis.fst | dot -Tpdf  > lemma2verbis.pdf


# Compila e gera a versão gráfica do lemma2verbif
fstcompile --isymbols=syms.txt --osymbols=syms.txt  lemma2verbif.txt | fstarcsort > lemma2verbif.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verbif.fst | dot -Tpdf  > lemma2verbif.pdf


# Gera a versão gráfica do lemma2verb
fstunion lemma2verbip.fst lemma2verbis.fst > lemma2verbAUX.fst
fstunion lemma2verbAUX.fst lemma2verbif.fst > lemma2verb.fst
rm lemma2verbAUX.fst || echo 'removal failed'
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2verb.fst | dot -Tpdf  > lemma2verb.pdf

# Gera a versão gráfica do lemma2word
fstunion lemma2verb.fst lemma2adverb.fst > lemma2wordAUX.fst
fstunion lemma2wordAUX.fst lemma2noun.fst > lemma2word.fst
rm lemma2wordAUX.fst || echo 'removal failed'
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait lemma2word.fst | dot -Tpdf  > lemma2word.pdf


##Gera a versão gráfica do word2lemma
fstinvert lemma2word.fst > word2lemma.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait word2lemma.fst | dot -Tpdf  > word2lemma.pdf


################### Testa os tradutores ################

# echo "Transdutor aluno :"
# fstrmepsilon aluno.fst | fsttopsort | fstprint --isymbols=syms.txt
# echo "Output: "
# fstcompose aluno.fst lemma2noun.fst  > resultado.fst
# fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


# echo "Transdutor inteligentemente :"
# fstrmepsilon inteligentemente.fst | fsttopsort | fstprint --isymbols=syms.txt
# echo "Output: "
# fstcompose inteligentemente.fst lemma2adverb.fst  > resultado.fst
# fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


# echo "Transdutor lavar lemma2verbip :"
# fstrmepsilon lavar.fst | fsttopsort | fstprint --isymbols=syms.txt
# echo "Output: "
# fstcompose lavar.fst lemma2verbip.fst  > resultado.fst
# fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


# echo "Transdutor lavar lemma2verbis :"
# fstrmepsilon lavar.fst | fsttopsort | fstprint --isymbols=syms.txt
# echo "Output: "
# fstcompose lavar.fst lemma2verbis.fst  > resultado.fst
# fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


# echo "Transdutor lavar lemma2verbif :"
# fstrmepsilon lavar.fst | fsttopsort | fstprint --isymbols=syms.txt
# echo "Output: "
# fstcompose lavar.fst lemma2verbif.fst  > resultado.fst
# fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


echo "Transdutor lavar lemma2word :"
fstrmepsilon lavar.fst | fsttopsort | fstprint --isymbols=syms.txt
echo "Output: "
fstcompose lavar.fst lemma2verb.fst  > resultado.fst
fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'


echo "Transdutor lavar word2lemma :"
fstrmepsilon lavar.fst | fsttopsort | fstprint --isymbols=syms.txt
echo "Output: "
fstcompose lavar.fst word2lemma.fst  > resultado.fst
fstproject --project_output resultado.fst | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=syms.txt | awk '{print $3}'
