<?
/**
 * getAllIngredients
 * @var name string
 */
$ingredientNames = Array();
$ingredients = Ingredient::getAllByName($name);
foreach($ingredients as $ingredients) {
    $ingredientNames[] = $ingredients->getName();
}
echo json_encode($ingredientNames);
?>
