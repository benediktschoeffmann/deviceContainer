<?
/**
 * getAllIngredients
 *
 */
$ingredientNames = Array();
$ingredients = Ingredient::getAll();
foreach($ingredients as $ingredients) {
    $ingredientNames[] = $ingredients->getName();
}
echo json_encode($ingredientNames);
?>
