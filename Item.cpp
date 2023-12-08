#include <SFML/Graphics.hpp>
#include <iostream>
#include <string>
#include <vector>
#include <time.h>
#include <cmath>
#include <windows.h>
#include "Item.h"

using namespace std;
using namespace sf;

int Item::collisionTest(Item& obj) {

	int distance = sqrt(pow(getPosition().x - obj.getPosition().x, 2) + pow(getPosition().y - obj.getPosition().y, 2));

	if (distance < getRadius() + obj.getRadius()) {
		if (obj.getColor() == Color::Red) {
			return 1;
		}
		else if (obj.getColor() == Color::Blue) {
			return 2;
		}
		else if (obj.getColor() == Color::Green) {
			return 3;
		}
		else if (obj.getColor() == Color::Yellow) {
			return 4;
		}
	}
}

Color Item::getColor() {
	return circle.getFillColor();
}

void Item::setColor(Color fillColor)
{
	circle.setFillColor(fillColor);
}

void Item::setPosition(double x, double y) {
	circle.setPosition(x,y);
}

Vector2f Item::getPosition() {
	return circle.getPosition();
}

float Item::getRadius() {
	return circle.getRadius();
}

CircleShape* Item::getCircleShape() {
	return &circle;
}
//원본에 접근하기 위해 포인터를 반환
