\copy barcodes (barcode_id, sample_id) FROM PROGRAM 'grep \" file_barcodes | sed s/,//g | awk ''{print $1",__s__"}''' WITH (FORMAT csv);
\copy clonotypes FROM PROGRAM 'awk ''{print $0",__s__"}'' file_clonotypes' DELIMITER ',' CSV HEADER;
\copy airr_rearrangement(cell_id,clone_id,sequence_id,sequence,sequence_aa,productive,rev_comp,v_call,v_cigar,d_call,d_cigar,j_call,j_cigar,c_call,c_cigar,sequence_alignment,germline_alignment,junction,junction_aa,junction_length,junction_aa_length,v_sequence_start,v_sequence_end,d_sequence_start,d_sequence_end,j_sequence_start,j_sequence_end,c_sequence_start,c_sequence_end,consensus_count,duplicate_count,is_cell,sample_id) FROM PROGRAM 'awk ''{print $0"\t__s__"}'' file_airr_rearrangement' DELIMITER E'\t' CSV HEADER;
\copy consensus_annotations FROM PROGRAM 'awk ''{print $0",__s__"}'' file_consensus_annotations' DELIMITER ',' CSV HEADER;
\copy filtered_contig_annotations(barcode,is_cell,contig_id,high_confidence,length,chain,v_gene,d_gene,j_gene,c_gene,full_length,productive,fwr1,fwr1_nt,cdr1,cdr1_nt,fwr2,fwr2_nt,cdr2,cdr2_nt,fwr3,fwr3_nt,cdr3,cdr3_nt,fwr4,fwr4_nt,reads,umis,raw_clonotype_id,raw_consensus_id,exact_subclonotype_id,sample_id) FROM PROGRAM 'awk ''{print $0",__s__"}'' file_filtered_contig_annotations' DELIMITER ',' CSV HEADER;

/*\copy clonotypes FROM 'file_clonotypes' DELIMITER ',' CSV HEADER;
\copy airr_rearrangement(cell_id,clone_id,sequence_id,sequence,sequence_aa,productive,rev_comp,v_call,v_cigar,d_call,d_cigar,j_call,j_cigar,c_call,c_cigar,sequence_alignment,germline_alignment,junction,junction_aa,junction_length,junction_aa_length,v_sequence_start,v_sequence_end,d_sequence_start,d_sequence_end,j_sequence_start,j_sequence_end,c_sequence_start,c_sequence_end,consensus_count,duplicate_count,is_cell) FROM 'file_airr_rearrangement' DELIMITER E'\t' CSV HEADER;
\copy consensus_annotations FROM 'file_consensus_annotations' DELIMITER ',' CSV HEADER;
\copy filtered_contig_annotations(barcode,is_cell,contig_id,high_confidence,length,chain,v_gene,d_gene,j_gene,c_gene,full_length,productive,fwr1,fwr1_nt,cdr1,cdr1_nt,fwr2,fwr2_nt,cdr2,cdr2_nt,fwr3,fwr3_nt,cdr3,cdr3_nt,fwr4,fwr4_nt,reads,umis,raw_clonotype_id,raw_consensus_id,exact_subclonotype_id) FROM 'file_filtered_contig_annotations' DELIMITER ',' CSV HEADER;*/