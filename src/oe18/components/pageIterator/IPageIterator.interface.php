<?php

interface IPageIterator {
    function getBoxes();
    function filterBoxes(FrontendBox[] $boxes);
    function iterateBoxes(FrontendBox[] $boxes);
}
