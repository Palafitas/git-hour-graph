#!/bin/bash
path_atual=$(pwd)
path_projetos="$1"
path_dados="$path_atual/dados"
path_relatorio="$path_atual/relatorio"

file_total_commits="$path_relatorio/total_commits.txt"
file_commits_por_projeto="$path_relatorio/commits_por_projeto.txt"

autor_commit="$2"
data_filtro_inicio="$3"
data_filtro_fim=$(date +"%Y-%m-%d")
file_relatorio="$path_relatorio/relatorio_$data_filtro_inicio_$data_filtro_fim.html"


if [ ! -d "$path_dados" ]; then
	mkdir $path_dados
else
	rm $path_dados/*.txt
fi

if [ ! -d "$path_relatorio" ]; then
	mkdir $path_relatorio
else
	rm $path_relatorio/*
fi

cd $path_projetos

if [ -d '.git' ]; then
	nome_repo=$(basename $path_projetos)
	git log --author=$autor_commit --remove-empty --all --ignore-missing --after=$data_filtro_inicio --format='%H,%ae,%aI' origin > $path_dados/"$nome_repo.txt"	
else
	for d in * ; do
		diretorio=$path_projetos/$d
		
		if [ -d "$diretorio" ]; then
			cd $diretorio
			git log --author=$autor_commit --remove-empty --all --ignore-missing --after=$data_filtro_inicio --format='%H,%ae,%aI' origin > $path_dados/"$d.txt"
		fi
	done
fi

cd $path_dados

total_commits=0
total_nove_dezoito=0
total_dezenove_vinte_tres=0
total_meia_noite_oito=0
total0=0
total1=0
total2=0
total3=0
total4=0
total5=0
total6=0
total7=0
total8=0
total9=0
total10=0
total11=0
total12=0
total13=0
total14=0
total15=0
total16=0
total17=0
total18=0
total19=0
total20=0
total21=0
total22=0
total23=0

for f in *.txt ; do

	arquivo=$path_dados/$f
	
	if [ -f "$arquivo" ]; then
		if [ -s "$arquivo" ]; then
			numero_commits=$(wc -l < $arquivo)		
			echo "Commits $f: $numero_commits" >> $file_commits_por_projeto

			while read linha; do
				echo $linha >> $file_total_commits
				
				commit_hash=$(awk -F ',' '{print $1}' <<< $linha)
				autor_email=$(awk -F ',' '{print $2}' <<< $linha)
				commit_data=$(awk -F ',' '{print $3}' <<< $linha)
				commit_hora=$(date -d "$commit_data" +"%H")
				numero_hora=$((10#$commit_hora))

				case $numero_hora in
					0)
						(( total0++ ))
						(( total_meia_noite_oito++ ))
						;;
					1)
						(( total1++ ))
						(( total_meia_noite_oito++ ))
						;;
					2)
						(( total2++ ))
						(( total_meia_noite_oito++ ))
						;;
					3)
						(( total3++ ))
						(( total_meia_noite_oito++ ))
						;;
					4)
						(( total4++ ))
						(( total_meia_noite_oito++ ))
						;;
					5)
						(( total5++ ))
						(( total_meia_noite_oito++ ))
						;;
					6)
						(( total6++ ))
						(( total_meia_noite_oito++ ))
						;;
					7)
						(( total7++ ))
						(( total_meia_noite_oito++ ))
						;;
					8)
						(( total8++ ))
						(( total_meia_noite_oito++ ))
						;;
					9)
						(( total9++ ))
						(( total_nove_dezoito++ ))
						;;
					10)
						(( total10++ ))
						(( total_nove_dezoito++ ))
						;;
					11)
						(( total11++ ))
						(( total_nove_dezoito++ ))
						;;
					12)
						(( total12++ ))
						(( total_nove_dezoito++ ))
						;;
					13)
						(( total13++ ))
						(( total_nove_dezoito++ ))
						;;
					14)
						(( total14++ ))
						(( total_nove_dezoito++ ))
						;;
					15)
						(( total15++ ))
						(( total_nove_dezoito++ ))
						;;
					16)
						(( total16++ ))
						(( total_nove_dezoito++ ))
						;;
					17)
						(( total17++ ))
						(( total_nove_dezoito++ ))
						;;
					18)
						(( total18++ ))
						(( total_nove_dezoito++ ))
						;;
					19)
						(( total19++ ))
						(( total_dezenove_vinte_tres++ ))
						;;
					20)
						(( total20++ ))
						(( total_dezenove_vinte_tres++ ))
						;;
					21)
						(( total21++ ))
						(( total_dezenove_vinte_tres++ ))
						;;
					22)
						(( total22++ ))
						(( total_dezenove_vinte_tres++ ))
						;;
					23)
						(( total23++ ))
						(( total_dezenove_vinte_tres++ ))
						;;				
				esac


				(( total_commits++ ))
				
			done <$arquivo
		fi
	fi
done

cd $path_atual

echo "Commits 09:00 -> 18:00 = $total_nove_dezoito" >> $file_commits_por_projeto
echo "Commits 19:00 -> 23:00 = $total_dezenove_vinte_tres" >> $file_commits_por_projeto
echo "Commits 00:00 -> 08:00 = $total_meia_noite_oito" >> $file_commits_por_projeto
echo "Total commits = $total_commits" >> $file_commits_por_projeto

cp -f template.html $file_relatorio

# Padrão
sed -i "s/AUTOR_COMMIT/$autor_commit/g" $file_relatorio
sed -i "s/DATA_FILTRO_INICIO/$data_filtro_inicio/g" $file_relatorio
sed -i "s/DATA_FILTRO_FIM/$data_filtro_fim/g" $file_relatorio

# Resumido
sed -i "s/resumido08/$total_meia_noite_oito/g" $file_relatorio
sed -i "s/resumido918/$total_nove_dezoito/g" $file_relatorio
sed -i "s/resumido1923/$total_dezenove_vinte_tres/g" $file_relatorio

# Completo
sed -i "s/completo00/$total0/g" $file_relatorio
sed -i "s/completo01/$total1/g" $file_relatorio
sed -i "s/completo02/$total2/g" $file_relatorio
sed -i "s/completo03/$total3/g" $file_relatorio
sed -i "s/completo04/$total4/g" $file_relatorio
sed -i "s/completo05/$total5/g" $file_relatorio
sed -i "s/completo06/$total6/g" $file_relatorio
sed -i "s/completo07/$total7/g" $file_relatorio
sed -i "s/completo08/$total8/g" $file_relatorio
sed -i "s/completo09/$total9/g" $file_relatorio
sed -i "s/completo10/$total10/g" $file_relatorio
sed -i "s/completo11/$total11/g" $file_relatorio
sed -i "s/completo12/$total12/g" $file_relatorio
sed -i "s/completo13/$total13/g" $file_relatorio
sed -i "s/completo14/$total14/g" $file_relatorio
sed -i "s/completo15/$total15/g" $file_relatorio
sed -i "s/completo16/$total16/g" $file_relatorio
sed -i "s/completo17/$total17/g" $file_relatorio
sed -i "s/completo18/$total18/g" $file_relatorio
sed -i "s/completo19/$total19/g" $file_relatorio
sed -i "s/completo20/$total20/g" $file_relatorio
sed -i "s/completo21/$total21/g" $file_relatorio
sed -i "s/completo22/$total22/g" $file_relatorio
sed -i "s/completo23/$total23/g" $file_relatorio
