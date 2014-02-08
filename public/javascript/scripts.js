$(function() {
	$('#tabs').tabify();

    Galleria.loadTheme('/galleria/themes/classic/galleria.classic.min.js');
    Galleria.run('.galleria');
});

function check_if_empty()
{
  if(document.getElementById("comment").value == '')
  {
      alert("Полето за коментар е празно!");
      return false;
  }
  return true;
}