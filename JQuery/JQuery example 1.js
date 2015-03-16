<script type="text/javascript">

    $(document).ready(function() {
        
        $('#img_dnn_ctr1053_Main_profileedit_dnnctlBirthday').hide();
        
        $('input[name *= "dnnctlBirthday"]').datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'mm/dd/yy',
                yearRange: (new Date().getFullYear() - 100) + ':' + (new Date().getFullYear())
            });
        });



$('.date').each(function(){ $
('#'+this.id).datepicker({ 
changeMonth: true, changeYear: true, dateFormat: 'dd/mm/yy', yearRange: (new Date().getFullYear() - 100) + ':' + (new Date().getFullYear()) }); });

            
 </script>